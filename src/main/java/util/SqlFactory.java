package util;

import _enum.DataType;
import _enum.IndexMethod;
import _enum.SupportedRowChangeMethod;
import common.Constants;
import model.Row;
import model.Table;
import model.TableIndex;

import java.util.List;

import static common.Constants.SQL_END_APPEND;
import static common.Constants.WRAP_STRING;

/**
 * @file: util.SqlFactory
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 10:32
 * @Company: www.xyb2b.com
 */

public class SqlFactory {

    private static final String SQL_SEPERATOR = " ";
    private static String lineOrder = ((char) ('A' - 1)) + "";
    private static String getLengthPartString(Row row){
        if (row.getLength()==null) return "";
        if (row.getDataType() == DataType.DECIMAL || row.getDataType() == DataType.DECIMAL_UNSIGNED){
            return String.format("(%d,%d)",row.getLength(),row.getDecimalLength());
        }else{
            return String.format("(%d)",row.getLength());
        }
    }

    private static String getNullAblePartString(Row row){
        if (row.isNullAble()){
            return "NULL";
        }
        return "NOT NULL";
    }

    private static String getDefaultValuePartString(Row row){
        if (row.getDefaultValue() != null && !row.getDefaultValue().isEmpty()){
            return "DEFAULT" + SQL_SEPERATOR + row.getDefaultValue();
        }
        return "";
    }

    private static String getCommentPartString(Row row){
        if (row.getComment() != null && !row.getComment().isEmpty()){
            return String.format("COMMENT \"%s\"",row.getComment());
        }
        return "";
    }

    private static String getTimeIsUpdateWhenModifyPartString(Row row){
        if (row.isTimeIsUpdateWhenModify()){
            return   String.format("ON%sUPDATE%sCURRENT_TIMESTAMP",SQL_SEPERATOR,SQL_SEPERATOR);
        }
        return "";
    }

    public static String getRenameRowSql(Table table,Row fromRow,Row toRow){
        return getAlterTableSql(table)+ "CHANGE" + SQL_SEPERATOR + "COLUMN" + SQL_SEPERATOR +
                String.format("`%s` `%s`",fromRow.getRowName(),toRow.getRowName()) + SQL_SEPERATOR + toRow.getDataType() + getLengthPartString(toRow) + SQL_SEPERATOR +
                getNullAblePartString(toRow) + SQL_SEPERATOR +
                getDefaultValuePartString(toRow) + SQL_SEPERATOR + getTimeIsUpdateWhenModifyPartString(toRow) + SQL_SEPERATOR +
                getCommentPartString(toRow)+SQL_END_APPEND;
    }

    private static String getRowSql(Table table,SupportedRowChangeMethod changeMethod, Row toRow){
        return getAlterTableSql(table)+ changeMethod.getMethodName() + SQL_SEPERATOR + "COLUMN" + SQL_SEPERATOR +
                String.format("`%s`",toRow.getRowName()) + SQL_SEPERATOR + toRow.getDataType() + getLengthPartString(toRow) + SQL_SEPERATOR +
                getNullAblePartString(toRow) + SQL_SEPERATOR +
                getDefaultValuePartString(toRow) + SQL_SEPERATOR + getTimeIsUpdateWhenModifyPartString(toRow) + SQL_SEPERATOR +
                getCommentPartString(toRow)+SQL_END_APPEND;
    }
    public static String getModifyRowSql(Table table,Row toRow){
        return getRowSql(table,SupportedRowChangeMethod.MODIFY,toRow);
    }

    public static String getAddRowSql(Table table,Row toRow){
        return getRowSql(table,SupportedRowChangeMethod.ADD,toRow);
    }


    public static String getDropRowSql(Table table,Row row){
        return getAlterTableSql(table) + String.format("DROP COLUMN `%s`",row.getRowName())+SQL_END_APPEND;
    }

    private static String rowNameListToString(List<String> rowNameList){
        StringBuilder builder = new StringBuilder();
        rowNameList.forEach(rowName -> builder.append(String.format("`%s`",rowName)).append(","));
        builder.deleteCharAt(builder.length()-1);
        return builder.toString();
    }

    public static String getPrimaryKeyChangeString(Table toTable){
        return getAlterTableSql(toTable)+ "DROP PRIMARY KEY,\r\nADD PRIMARY KEY " + String.format("(%s)",rowNameListToString(toTable.getPrimaryKeyRowNameList()))+SQL_END_APPEND;
    }

    public static String getDropRowTipsInSameNameTable(Table table,Row fromRow, Row toRow){
        return String.format("-- ----------------------------\r\n" +
                "--  字段重命名检测：【%s】表格中的 【%s】字段名可能改成了 【%s】\r\n" +
                "--  如果不是，请运行以下语句删除旧数据列\r\n"+
                "--  %s"+
                "--  如果是,请运行以下语句\r\n" +
                "-- ----------------------------",table.getTableName(),fromRow.getRowName(),getDropRowSql(table,fromRow),toRow.getRowName());
    }
    public static String getDropRowTipsInDifferentNameTable(Table fromTable,Row fromRow,Table toTable, Row toRow){
        return String.format("-- ----------------------------\r\n" +
                "--  字段重命名检测：【%s】表格中的 【%s】 字段可能改成了【%s】表格中的 【%s】字段\r\n" +
                "--  如果不是，请运行以下语句删除旧数据列\r\n"+
                "--  %s"+
                "--  如果是,请运行以下语句\r\n" +
                "-- ----------------------------",fromTable.getTableName(),fromRow.getRowName(),toTable.getTableName(),toRow.getRowName(),getDropRowSql(toTable,fromRow));
    }


    //Table 的语句
    private static String getIndexMethodPart(IndexMethod indexMethod){
        if (indexMethod!= IndexMethod.NONE){
            return "USING " + indexMethod.getIndexMethod();
        }
        return "";
    }

    public static String getAddIndexString(Table table,TableIndex toAddTableIndex){
        return getAlterTableSql(table)+ String.format("ADD %s INDEX `%s` (%s) %s",
                toAddTableIndex.getIndexType().getIndexName(),toAddTableIndex.getIndexName(),rowNameListToString(toAddTableIndex.getRowList()),getIndexMethodPart(toAddTableIndex.getIndexMethod()))+SQL_END_APPEND;
    }

    public static String getTableCommentChangeString(Table table,String toComment){
        return getAlterTableSql(table)+String.format("COMMENT='%s'",toComment) +SQL_END_APPEND;
    }

    public static String getCharsetChangeString(Table table,String toCharset){
        return getAlterTableSql(table)+ String.format("DEFAULT CHARACTER SET=%s",toCharset) +SQL_END_APPEND;
    }

    public static String getDropIndexString(Table table,TableIndex toDropTableIndex){
        return  getAlterTableSql(table)+  String.format("DROP INDEX `%s`",toDropTableIndex.getIndexName()) +SQL_END_APPEND;
    }

    public static String getDropTableSql(Table table){
        return String.format("DROP TABLE IF EXISTS `%s`",table.getTableName()) +SQL_END_APPEND;
    }
    public static String getDisabledDropTableSql(Table table){
        return Constants.SQL_DISABLE + SQL_SEPERATOR + getDropTableSql(table);
    }

    public static String getRenameTableSql(Table fromTable,Table toTable){
        return String.format("RENAME TABLE %s TO %s",fromTable.getTableName(),toTable.getTableName())+SQL_END_APPEND;
    }
    private static String getAlterTableSql(Table table){
        return String.format("ALTER TABLE `%s`%s",table.getTableName(),SQL_SEPERATOR);
    }


    public static String getDropTableTips(Table fromTable,Table toTable){
        return String.format( "-- ----------------------------\r\n" +
                "--  表格重命名检测：表格 【%s】 可能改成了 【%s】\r\n" +
                "--  如果不是，请执行以下语句删除旧表格，并直接跳过【分割线%s】间的所有语句\r\n" +
                "--  %s"+
                "--  如果是,请运行以下语句\r\n" +
                "-- ----------------------------",fromTable.getTableName(),toTable.getTableName(),getLineOrder(),getDropTableSql(fromTable));

    }

    public static String getStartSplitLine(){
        return String.format("/*--------------------分割线%s开始-----------------------*/",getNextLineOrder())+WRAP_STRING+WRAP_STRING;
    }
    public static String getEndSplitLine(){
        return WRAP_STRING+WRAP_STRING+String.format("/*--------------------分割线%s结束-----------------------*/",getLineOrder())+WRAP_STRING+WRAP_STRING;
    }
    public static String getModifyTableStartTips(Table table){
        return WRAP_STRING+String.format("/*--------------------【START】表格%s的修改SQL语句-----------------------*/",table.getTableName())+WRAP_STRING+WRAP_STRING;
    }
    public static String getModifyTableEndTips(Table table){
        return WRAP_STRING+String.format("/*--------------------【END】表格%s的修改SQL语句-----------------------*/",table.getTableName())+WRAP_STRING+WRAP_STRING;
    }
    public static String getAddTableStartTips(){
        return "/*==================【Start】创建表格语句==================*/" +WRAP_STRING+WRAP_STRING;
    }
    public static String getAddTableEndTips(){
        return WRAP_STRING+"/*==================【End】创建表格语句==================*/" +WRAP_STRING+WRAP_STRING;
    }
    public static String getModifyTableStartTips(){
        return WRAP_STRING+"/*==================【Start】以下是修改表格语句==================*/" +WRAP_STRING+WRAP_STRING;
    }
    public static String getModifyTableEndTips(){
        return WRAP_STRING+WRAP_STRING+"/*==================【End】修改语句结束==================*/" +WRAP_STRING+WRAP_STRING;
    }
    public static String getRealDropTableStartTips(){
        return WRAP_STRING+"/*==================【Start】待删除表格语句==================*/" +WRAP_STRING+WRAP_STRING;
    }
    public static String getRealDropTableEndTips(){
        return WRAP_STRING+WRAP_STRING+"/*==================【End】创建修改语句==================*/" +WRAP_STRING+WRAP_STRING;
    }


    private static String getNextLineOrder(){
        char[] chars = lineOrder.toCharArray();
        chars[chars.length-1] +=1;
        for (int i = chars.length-1; i >=0; i--) {
            if (chars[i]>'Z'){
                chars[i] = 'A';
                if (i != 0){
                    chars[i-1] +=1;
                }else{
                    char[] toChars = new char[chars.length + 1];
                    System.arraycopy(new char[]{'A'},0,toChars,0,1);
                    System.arraycopy(chars,0,toChars,1,chars.length);
                    chars = toChars;
                }
            }
        }
        lineOrder = new String(chars);
        return lineOrder;
    }
    private static String getLineOrder(){
        return lineOrder;
    }

    public static void main(String[] args) {
        for (int i = 0; i < 10000; i++) {
            System.out.println(getNextLineOrder());
        }
    }
}
