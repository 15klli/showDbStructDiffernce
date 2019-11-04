package model;

import java.util.List;

/**
 * @file: model.DataBase
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 11:59
 * @Company: www.xyb2b.com
 */

public class DataBase {
    private String dbName;

    private List<Table> tableList;

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }

    public List<Table> getTableList() {
        return tableList;
    }

    public void setTableList(List<Table> tableList) {
        this.tableList = tableList;
    }
}
