package model;

import java.util.ArrayList;
import java.util.List;

/**
 * @file: model.Table
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/1 15:35

 */

public class Table {

    private String createSql;

    private List<Row> rowList;

    private String comment;

    private String tableName;

    private Long autoIncreament;

    private String charset;

    private String engine;
    //索引部分
    //主键索引
    private List<String> primaryKeyRowNameList;
    //其他索引
    private List<TableIndex> tableIndexList  = new ArrayList<>(4);

    public List<Row> getRowList() {
        return rowList;
    }

    public void setRowList(List<Row> rowList) {
        this.rowList = rowList;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Long getAutoIncreament() {
        return autoIncreament;
    }

    public void setAutoIncreament(Long autoIncreament) {
        this.autoIncreament = autoIncreament;
    }

    public String getCharset() {
        return charset;
    }

    public void setCharset(String charset) {
        this.charset = charset;
    }

    public List<String> getPrimaryKeyRowNameList() {
        return primaryKeyRowNameList;
    }

    public void setPrimaryKeyRowNameList(List<String> primaryKeyRowNameList) {
        this.primaryKeyRowNameList = primaryKeyRowNameList;
    }

    public List<TableIndex> getTableIndexList() {
        return tableIndexList;
    }

    public void setTableIndexList(List<TableIndex> tableIndexList) {
        this.tableIndexList = tableIndexList;
    }

    public String getEngine() {
        return engine;
    }

    public void setEngine(String engine) {
        this.engine = engine;
    }

    public String getCreateSql() {
        return createSql;
    }

    public void setCreateSql(String createSql) {
        this.createSql = createSql;
    }

    @Override
    public String toString() {
        return "Table{" +
                "tableName='" + tableName + '\'' +
                ", rowList=" + rowList +
                ", comment='" + comment + '\'' +
                ", autoIncreament=" + autoIncreament +
                ", charset='" + charset + '\'' +
                ", engine='" + engine + '\'' +
                ", primaryKeyRowNameList=" + primaryKeyRowNameList +
                ", tableIndexList=" + tableIndexList +
                '}';
    }

    public boolean equalsPrimaryKeyList(List<String> anotherList){
        //可能为null
        if (this.primaryKeyRowNameList == anotherList || this.primaryKeyRowNameList.equals(anotherList)) return true;
        //因为有顺序问题
        if (this.primaryKeyRowNameList.size()!=anotherList.size()){
            return false;
        }else{
            for (String primaryKey : this.primaryKeyRowNameList) {
                if (!anotherList.contains(primaryKey)) return false;
            }
            return true;
        }
    }

    public boolean isTableIndexListContains(TableIndex tableIndex){
        for (TableIndex myIndex : this.tableIndexList) {
            if (myIndex.equals(tableIndex)) return true;
        }
        return false;
    }

    public Row indexRowByName(String rowName){
        for (Row row : this.rowList) {
            if (row.getRowName().equalsIgnoreCase(rowName)) return row;
        }
        return null;
    }
}
