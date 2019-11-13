import model.DBConnectionInfo;
import model.SQLResult;
import util.GeneratorUtils;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;

/**
 * @file: PACKAGE_NAME.Demo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/1 15:05

 */

public class Demo {


    public static void main(String[] args) throws IOException {
//        demoFromFile();
        demoFromUrl();
    }

    private static void demoFromFile() throws IOException {
        SQLResult sqlResult = GeneratorUtils.generateFromFile("fromTable.sql", "toTable.sql");
        FileWriter canRunWriter = new FileWriter("canRun.sql");
        FileWriter needHandleWriter = new FileWriter("needHandle.sql");
        //可以直接运行，不会损坏已有数据
        //因为只有 增加表格/增加字段/修改字段（不含删除） 的操作
        canRunWriter.write(sqlResult.getCanRunSqlString());
        //需要人工处理的sql 语句
        //因为包含了删除/重命名等语句
        needHandleWriter.write(sqlResult.getNeedHandleSqlString());
        canRunWriter.flush();
        needHandleWriter.flush();
    }

    private static void demoFromUrl() throws IOException {

        DBConnectionInfo fromDbConnectionInfo = new DBConnectionInfo();
        fromDbConnectionInfo.setUser("root");
        fromDbConnectionInfo.setPassword("778163");
        fromDbConnectionInfo.setUrl("jdbc:mysql://localhost:3306/bb?allowMultiQueries=true&useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=GMT%2B8");
        fromDbConnectionInfo.setDriver("com.mysql.cj.jdbc.Driver");

        DBConnectionInfo toDbConnectionInfo = new DBConnectionInfo();
        toDbConnectionInfo.setUser("bb");
        toDbConnectionInfo.setPassword("123456");
        toDbConnectionInfo.setUrl("jdbc:mysql://172.16.16.5:3306/bbtest?allowMultiQueries=true&useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=GMT%2B8");
        toDbConnectionInfo.setDriver("com.mysql.cj.jdbc.Driver");
        SQLResult sqlResult = GeneratorUtils.generateFromUrl(fromDbConnectionInfo, toDbConnectionInfo);

        FileWriter canRunWriter = new FileWriter("canRun.sql");
        FileWriter needHandleWriter = new FileWriter("needHandle.sql");
        //可以直接运行，不会损坏已有数据
        //因为只有 增加表格/增加字段/修改字段（不含删除） 的操作
        canRunWriter.write(sqlResult.getCanRunSqlString());
        //需要人工处理的sql 语句
        //因为包含了删除/重命名等语句
        needHandleWriter.write(sqlResult.getNeedHandleSqlString());
        canRunWriter.flush();
        needHandleWriter.flush();
    }

}
