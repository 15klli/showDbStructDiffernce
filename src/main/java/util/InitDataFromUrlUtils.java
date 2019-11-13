package util;

import com.mysql.cj.util.StringUtils;
import common.Constants;
import common._enum.DataType;
import common._exception.InitDataFromDbException;
import common._exception.LackOfRequiredInfoException;
import model.DBConnectionInfo;
import model.Row;
import model.Table;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * Create by Lingo
 */

public class InitDataFromUrlUtils {
    private static Connection connection;
    private static Statement statement;

    private InitDataFromUrlUtils() {
    }

    public static List<Table> getTableList(DBConnectionInfo dbConnectionInfo)  {
        if (StringUtils.isNullOrEmpty(dbConnectionInfo.getUser())){
            throw new LackOfRequiredInfoException("user");
        }
         if (StringUtils.isNullOrEmpty(dbConnectionInfo.getDriver())){
            throw new LackOfRequiredInfoException("driver");
        }
         if (StringUtils.isNullOrEmpty(dbConnectionInfo.getPassword())){
            throw new LackOfRequiredInfoException("password");
        }
         if (StringUtils.isNullOrEmpty(dbConnectionInfo.getUrl())){
            throw new LackOfRequiredInfoException("url");
        }
        try {
            Class.forName(dbConnectionInfo.getDriver());
            connection = DriverManager.getConnection(dbConnectionInfo.getUrl(), dbConnectionInfo.getUser(), dbConnectionInfo.getPassword());
            statement = connection.createStatement();
            return getTableInfoList();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static List<Table> getTableInfoList() throws SQLException {
        ResultSet resultSet = statement.executeQuery("Show tables");
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
        return InitDataFromFile.getTablesFromSql(allSql.toString());
    }
}
