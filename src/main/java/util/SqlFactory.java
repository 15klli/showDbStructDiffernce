package util;

import _enum.DataType;
import _enum.SupportedRowChangeMethod;
import model.Row;
import model.Table;
import model.TableIndex;

import java.util.List;

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

    private static String getRowSql(SupportedRowChangeMethod changeMethod, Row toRow){
        String builder = changeMethod.getMethodName() + SQL_SEPERATOR + "COLUMN" + SQL_SEPERATOR +
                toRow.getRowName() + SQL_SEPERATOR + toRow.getDataType() + getLengthPartString(toRow) + SQL_SEPERATOR +
                getNullAblePartString(toRow) + SQL_SEPERATOR +
                getDefaultValuePartString(toRow) + SQL_SEPERATOR +
                getCommentPartString(toRow);
        return builder;
    }

    public static String getModifySql(Row toRow){
        return getRowSql(SupportedRowChangeMethod.MODIFY,toRow);
    }
    public static String getAddRowSql(Row toRow){
        return getRowSql(SupportedRowChangeMethod.ADD,toRow);
    }

    public static String getDropTableSql(Table table){
        return String.format("DROP TABLE IF EXISTS `%s`",table.getTableName());
    }

//    public static String showDiff(Row fromRow, Row toRow) {
//        if (!fromRow.getRowName().equals(toRow.getRowName())){
//            throw new ComparingException("字段名相同才进行判断");
//        }
//        if (!fromRow.equals(toRow)){
//            return SqlFactory.getModifySql(toRow);
//        }
//        return null;
//    }

    private static String rowNameListToString(List<String> rowNameList){
        StringBuilder builder = new StringBuilder();
        rowNameList.forEach(rowName -> builder.append(String.format("`%s`",rowName)).append(","));
        builder.deleteCharAt(builder.length()-1);
        return builder.toString();
    }

    public static String getPrimaryKeyChangeString(Table toTable){
        return "DROP PRIMARY KEY,\r\nADD PRIMARY KEY " + String.format("(%s)",rowNameListToString(toTable.getPrimaryKeyRowNameList()));
    }

    public static String getDropIndexString(TableIndex toDropTableIndex){
        return String.format("DROP INDEX `%s`",toDropTableIndex.getIndexName());
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
}
