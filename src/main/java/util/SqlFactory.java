package util;

import _enum.DataType;
import _enum.SupportedRowChangeMethod;
import model.Row;
import model.Table;
import model.TableIndex;

import java.util.List;

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

    //CHANGE COLUMN `Fexchange_rate` `Fexchange_rate2`  int(11) UNSIGNED NULL DEFAULT NULL COMMENT '直接汇率: 一百万外币兑人民币(元)' AFTER `Ftarget_currency_id`;
    public static String getRenameRowSql(Row fromRow,Row toRow){
        return "CHANGE" + SQL_SEPERATOR + "COLUMN" + SQL_SEPERATOR +
                String.format("`%s` `%s`",fromRow.getRowName(),toRow.getRowName()) + SQL_SEPERATOR + toRow.getDataType() + getLengthPartString(toRow) + SQL_SEPERATOR +
                getNullAblePartString(toRow) + SQL_SEPERATOR +
                getDefaultValuePartString(toRow) + SQL_SEPERATOR +
                getCommentPartString(toRow);
    }

    private static String getRowSql(SupportedRowChangeMethod changeMethod, Row toRow){
        return changeMethod.getMethodName() + SQL_SEPERATOR + "COLUMN" + SQL_SEPERATOR +
                String.format("`%s`",toRow.getRowName()) + SQL_SEPERATOR + toRow.getDataType() + getLengthPartString(toRow) + SQL_SEPERATOR +
                getNullAblePartString(toRow) + SQL_SEPERATOR +
                getDefaultValuePartString(toRow) + SQL_SEPERATOR +
                getCommentPartString(toRow);
    }
    public static String getModifyRowSql(Row toRow){
        return getRowSql(SupportedRowChangeMethod.MODIFY,toRow);
    }

    public static String getAddRowSql(Row toRow){
        return getRowSql(SupportedRowChangeMethod.ADD,toRow);
    }

    public static String getDropRowSql(Row row){
        return String.format("DROP COLUMN `%s`",row.getRowName());
    }

    public static String getDropRowSqlWithTable(Table table,Row row){
        return getAlterTableSql(table)+ WRAP_STRING + String.format("DROP COLUMN `%s`",row.getRowName());
    }

    private static String rowNameListToString(List<String> rowNameList){
        StringBuilder builder = new StringBuilder();
        rowNameList.forEach(rowName -> builder.append(String.format("`%s`",rowName)).append(","));
        builder.deleteCharAt(builder.length()-1);
        return builder.toString();
    }

    public static String getPrimaryKeyChangeString(Table toTable){
        return "DROP PRIMARY KEY,\r\nADD PRIMARY KEY " + String.format("(%s)",rowNameListToString(toTable.getPrimaryKeyRowNameList()));
    }

    public static String getDropRowTipsInSameNameTable(Table table,Row fromRow, Row toRow){
        return String.format("/*\r\n==================\r\n重命名：【%s】表格中的 【%s】字段名可能改成了 【%s】\r\n如果是,请运行以下语句\r\n==================\r\n*/",
                table.getTableName(),fromRow.getRowName(),toRow.getRowName());
    }
    public static String getDropRowTipsInDifferentNameTable(Table fromTable,Row fromRow,Table toTable, Row toRow){
        return String.format("/*\r\n==================\r\n重命名：【%s】表格中的 【%s】 字段可能改成了%s表格中的 【%s】字段\r\n如果是,请运行以下语句\r\n==================\r\n*/",
                fromTable.getTableName(),fromRow.getRowName(),toTable.getTableName(),toRow.getRowName());
    }


    //ADD FULLTEXT INDEX `b2` (`Fpayment_refuse_reason`) ;
    public static String getAddIndexString(TableIndex toAddTableIndex){
        return String.format("ADD %s INDEX `%s` (%s)",
                toAddTableIndex.getIndexType().getIndexName(),toAddTableIndex.getIndexName(),rowNameListToString(toAddTableIndex.getRowList()));
    }

    public static String getCommentChangeString(String toComment){
        return String.format("COMMENT='%s'",toComment);
    }

    public static String getCharsetChangeString(String toCharset){
        return String.format("DEFAULT CHARACTER SET=%s",toCharset);
    }

    public static String getDropIndexString(TableIndex toDropTableIndex){
        return String.format("DROP INDEX `%s`",toDropTableIndex.getIndexName());
    }

    //Table 的语句
    public static String getDropTableSql(Table table){
        return String.format("DROP TABLE IF EXISTS `%s`",table.getTableName());
    }

    public static String getRenameTableSql(Table fromTable,Table toTable){
        return String.format("RENAME TABLE %s TO %s",fromTable.getTableName(),toTable.getTableName());
    }

    public static String getDropTableTips(Table fromTable,Table toTable){
        return String.format("/*\r\n==================\r\n重命名：表格 【%s】 可能改成了 【%s】\r\n如果是,请运行以下语句\r\n==================\r\n*/",
                fromTable.getTableName(),toTable.getTableName());
    }

    public static String getAlterTableSql(Table table){
        return String.format("ALTER TABLE `%s`",table.getTableName());
    }

    public static String getSplitLine(){
        return "/*-------------------------------------------------*/";
    }
}
