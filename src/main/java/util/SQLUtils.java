package util;

import common.Constants;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

/**
 * Create by Lingo
 */

public class SQLUtils {
    private static String driver;

    private static String url;

    private static String user;

    private static String password;


    static {
        Properties properties = new Properties();
        try {properties.load(new FileInputStream("src/main/resources/sql.properties"));
            driver = properties.getProperty("fromDB.driver");
            url = properties.getProperty("fromDB.url");
            user = properties.getProperty("fromDB.user");
            password = properties.getProperty("fromDB.password");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



//    public static Table getTableInfo(String tableName) throws ClassNotFoundException, SQLException {
//        Class.forName(driver);
//        Connection connection = DriverManager.getConnection(url, user, password);
//
//        String sqlDir = "select * from "+ tableName;
//        PreparedStatement stmt =connection.prepareStatement(sqlDir);
//        ResultSet rs = stmt.executeQuery(sqlDir);
//        ResultSetMetaData rsMetaData = rs.getMetaData();
//        Table Table =new Table();
//        Table.setName(tableName);
//        ColumnInfo temp =null;
//        for (int i = 0; i < rsMetaData.getColumnCount(); i++) {
//            temp = new ColumnInfo();
//            String columnName = rsMetaData.getColumnName(i + 1);
//            temp.setName(columnName);
//            temp.setComment(getColRemark(tableName,columnName));
//            temp.setJdbcTypeInt(rsMetaData.getColumnType(i+1));
//            temp.setJavaClassName(rsMetaData.getColumnClassName(i+1));
//            temp.setIsNullable(rsMetaData.isNullable(i+1));
//            Table.getColumnInfoList().add(temp);
//        }
//        Table.setComment(getTableRemark(tableName));
//        List<String> primaryKeys = getPrimaryKeys(tableName);
//        for (ColumnInfo columnInfo : Table.getColumnInfoList()) {
//            columnInfo.setIsPrimary(primaryKeys.contains(columnInfo.getName()) ? 1 : 0);
//        }
//        connection.close();
//        return Table;
//    }

    private static String getColRemark(String tableName, String colName) throws SQLException {
        Connection connection = DriverManager.getConnection(url, user, password);
        DatabaseMetaData metaData = connection.getMetaData();
        String dbName = connection.getCatalog();
        ResultSet columns = metaData.getColumns(dbName, null, tableName, colName);
        String remark = "";
        while (columns.next()){
            remark = columns.getString("REMARKS");
            break;
        }
        connection.close();
        return  remark;
    }

    private static String getTableRemark(String tableName) throws SQLException {
        Connection connection = DriverManager.getConnection(url, user, password);
        DatabaseMetaData metaData = connection.getMetaData();
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM information_schema.TABLES  WHERE table_name = '" + tableName +"'");
        String tableRemark = "";
        while (rs.next()){
            tableRemark = rs.getString("TABLE_COMMENT");
            break;
        }
        connection.close();
        return tableRemark;
    }

    private static List<String> getPrimaryKeys(String tableName) throws SQLException {
        Connection connection = DriverManager.getConnection(url, user, password);
        DatabaseMetaData metaData = connection.getMetaData();
        String dbName = connection.getCatalog();
        ResultSet rs = metaData.getPrimaryKeys(dbName, null, tableName);
        List<String> keyList = new LinkedList<>();
        while(rs.next()) {
            keyList.add(rs.getString("COLUMN_NAME"));
        }
        connection.close();
        return keyList;
    }




    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Connection connection = DriverManager.getConnection(url, user, password);
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("Show tables");// 查询此数据库有多少个表格
        List<String> tableList = new ArrayList<>();
        while (resultSet.next()){
            tableList.add(resultSet.getString(1));
        }
        StringBuilder allSql = new StringBuilder();
        for (String tableName : tableList) {
            ResultSet createResult = statement.executeQuery(String.format("SHOW CREATE TABLE `%s`", tableName));
            createResult.next();
            allSql.append(createResult.getString(2).replaceAll("\n", "\r\n"))
                    .append(Constants.SQL_END_APPEND);
            createResult.close();
        }
        InitDataFromFile.getTablesFromSql(allSql.toString()).forEach(System.out::println);

    }

}
