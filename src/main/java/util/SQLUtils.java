package util;

import model.Table;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
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
        try {properties.load(new FileInputStream("src/main/resources/sqlDir.properties"));
            driver = properties.getProperty("driver");
            url = properties.getProperty("url");
            user = properties.getProperty("user");
            password = properties.getProperty("password");
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
        getTableRemark("t_bb_origin");
    }
}
