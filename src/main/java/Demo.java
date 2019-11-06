import model.SQLResult;
import util.GeneratorUtils;

import java.io.FileWriter;
import java.io.IOException;

/**
 * @file: PACKAGE_NAME.Demo
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/1 15:05

 */

public class Demo {


    public static void main(String[] args) throws IOException {
        demo();
    }

    private static void demo() throws IOException {
        SQLResult sqlResult = GeneratorUtils.generate("db1.sql", "db2.sql");
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
