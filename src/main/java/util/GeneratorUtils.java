package util;

import common.Constants;
import model.SQLResult;
import model.Table;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * @file: util.GeneratorUtils
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/6 16:20

 */

public class GeneratorUtils {

    public static SQLResult generate(InputStream fromFileInputStream, InputStream toFileInputStream){
        if (fromFileInputStream == null || toFileInputStream ==null){
            throw new NullPointerException("文件输入流为null!请检查文件名");
        }
        try {
            List<Table> fromTableList = InitDataFromFile.getTablesFromInputStream(fromFileInputStream);
            List<Table> toTableList = InitDataFromFile.getTablesFromInputStream(toFileInputStream);
            Generator generator = new Generator(fromTableList, toTableList);
            SQLResult sqlResult = generator.generate();
            return sqlResult;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static SQLResult generate(String fromFileName, String toFileName) throws IOException {
        return generate(Constants.defaultSqlDirName,fromFileName,toFileName);
    }
    public static SQLResult generate(String directoryPath, String fromFileName, String toFileName) throws IOException {
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
            return generate(fromStream, toStream);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

}
