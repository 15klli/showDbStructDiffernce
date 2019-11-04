import model.Table;
import util.Generator;
import util.InitDataFromFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @file: PACKAGE_NAME.Main
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/1 15:05
 * @Company: www.xyb2b.com
 */

public class Main {


    public static void main(String[] args) throws IOException {
        handle();
//        test();
    }

    private static void test(){
        List<String> a = new ArrayList<>();
        a.add("a");
        a.add("b");
        List<String> b = new ArrayList<>();
        b.add("b");
        b.add("a");
        System.out.println(a.equals(b));
    }

    private static void handle() throws IOException {
        List<Table> fromTableList = InitDataFromFile.getTablesFromFile("db1.sql");
        List<Table> toTableList = InitDataFromFile.getTablesFromFile("db2.sql");
        Generator generator = new Generator(fromTableList, toTableList);

        System.out.println(generator.generate());
    }

}
