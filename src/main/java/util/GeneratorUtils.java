package util;

import common.Constants;
import model.DBConnectionInfo;
import model.SQLResult;
import model.Table;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * @file: util.GeneratorUtils
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/6 16:20

 */

public class GeneratorUtils {

    /**
     * 生成sql
     * @param fromFileInputStream 待升级的数据库
     * @param toFileInputStream 升级后的目标数据库
     * @return
     */
    public static SQLResult generateFromFile(InputStream fromFileInputStream, InputStream toFileInputStream){
        if (fromFileInputStream == null || toFileInputStream ==null){
            throw new NullPointerException("文件输入流为null!请检查文件名");
        }
        try {
            List<Table> fromTableList = InitDataFromFile.getTablesFromInputStream(fromFileInputStream);
            List<Table> toTableList = InitDataFromFile.getTablesFromInputStream(toFileInputStream);
            return getSqlResult(fromTableList, toTableList);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static SQLResult getSqlResult(List<Table> fromTableList, List<Table> toTableList) {
        Generator generator = new Generator(fromTableList, toTableList);
        SQLResult sqlResult = generator.generate();
        return sqlResult;
    }

    /**
     * 生成sql
     * @warning: 默认在 src/main/resources/sqlDir 目录下
     * @param fromFileName 待升级的数据库 sql文件名
     * @param toFileName 升级后的目标数据库 sql文件名
     * @return
     */
    public static SQLResult generateFromFile(String fromFileName, String toFileName) throws IOException {
        return generateFromFile(Constants.defaultSqlDirName,fromFileName,toFileName);
    }



    /**
     * 生成sql
     * @param directoryPath sql文件处于的文件夹路径
     * @param fromFileName 待升级的数据库 sql文件名
     * @param toFileName 升级后的目标数据库 sql文件名
     * @return
     * @throws IOException
     */
    public static SQLResult generateFromFile(String directoryPath, String fromFileName, String toFileName) throws IOException {
        if (directoryPath == null || directoryPath.isEmpty()){
            throw new NullPointerException("sql文件所处的文件夹名为空");
        }
        if (fromFileName == null || fromFileName.isEmpty()){
            throw new NullPointerException("[fromFile=null]需升级的sql文件名为空");
        }
        if (toFileName == null || toFileName.isEmpty()){
            throw new NullPointerException("[toFile=null]升级后的sql文件名为空");
        }
        try (FileInputStream fromStream = new FileInputStream(directoryPath+"/"+fromFileName);
             FileInputStream toStream = new FileInputStream(directoryPath+"/"+toFileName)){
            return generateFromFile(fromStream, toStream);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static SQLResult generateFromUrl(DBConnectionInfo fromDb,DBConnectionInfo toDb) {
        List<Table> fromTableList = InitDataFromUrlUtils.getTableList(fromDb);
        List<Table> toTableList = InitDataFromUrlUtils.getTableList(toDb);
        return getSqlResult(fromTableList,toTableList);
    }

}
