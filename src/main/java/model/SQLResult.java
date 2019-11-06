package model;

import java.util.*;

/**
 * @file: util.Generator
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 11:56
 * @Company: www.xyb2b.com
 */

public class SQLResult {

    private List<Table> fromTableList;

    private List<Table> toTableList;

    private String canRunSqlString;

    private String needHandleSqlString;

    public List<Table> getFromTableList() {
        return fromTableList;
    }

    public void setFromTableList(List<Table> fromTableList) {
        this.fromTableList = fromTableList;
    }

    public void setToTableList(List<Table> toTableList) {
        this.toTableList = toTableList;
    }

    public List<Table> getToTableList() {
        return toTableList;
    }

    public String getCanRunSqlString() {
        return canRunSqlString;
    }

    public void setCanRunSqlString(String canRunSqlString) {
        this.canRunSqlString = canRunSqlString;
    }


    public String getNeedHandleSqlString() {
        return needHandleSqlString;
    }

    public void setNeedHandleSqlString(String needHandleSqlString) {
        this.needHandleSqlString = needHandleSqlString;
    }
}
