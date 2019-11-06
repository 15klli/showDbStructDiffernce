package util;

import common._enum.DataType;
import common._enum.IndexMethod;
import common._enum.IndexType;
import common._exception.NotSupportEngine;
import common._exception.NotSupportFileException;
import common.Constants;
import model.Row;
import model.Table;
import model.TableIndex;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;

import static common.Constants.*;

/**
 * @file: util.InitDataFromFile
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/1 16:22

 */

public class InitDataFromFile {

    private static List<Table> getTablesFromFile(String directoryName,String fileName) throws IOException {
        try(InputStream resourceAsStream = InitDataFromFile.class.getClassLoader().getResourceAsStream(directoryName+"/"+fileName)) {
            return getTablesFromInputStream(resourceAsStream);
        }
    }
    private static List<Table> getTablesFromFile(String fileName) throws IOException {
        return getTablesFromFile(defaultSqlDirName,fileName);
    }

    public static List<Table> getTablesFromInputStream(InputStream inputStream) throws IOException {
        String fileContent = getFileContent(inputStream);
        List<Integer> startPosList = getStartPosList(fileContent);
        List<Integer> endPosList = getEndPosList(fileContent);
        if (startPosList.isEmpty() || endPosList.isEmpty()){
            throw new RuntimeException("没有一个完整的table创建语句");
        }
        if (startPosList.size() != endPosList.size()){
            throw new RuntimeException("有不完整的sql语句或不支持的版本");
        }
        List<String> tableStringList = getTableStringList(fileContent,startPosList,endPosList);
        List<Table> tableList = new ArrayList<>(tableStringList.size());
        tableStringList.forEach(tableString ->{
            Table table = getTableInfo(splitLines(tableString));
            table.setCreateSql(tableString);
            tableList.add(table);
        });
        return tableList;
    }


    private static String getFileContent(InputStream inputStream) throws IOException {
        StringBuilder content = new StringBuilder();
        assert inputStream != null;
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
        String tempStr;
        while ((tempStr = bufferedReader.readLine()) != null) {
            content.append(tempStr).append(WRAP_STRING);
        }
        return handleBlank(content.toString());
    }

    private static String handleBlank(String content){
        //保证只有一个空格
        return content.replaceAll("[^\\S(\r\n)]+", SEPERATOR);
    }

    private static List<String> getTableStringList(String fileContent,List<Integer> startPosList,List<Integer> endPosList){
        assert startPosList.size() == endPosList.size();
        List<String> tableList = new ArrayList<>(startPosList.size());
        for (int i = 0; i < startPosList.size(); i++) {
            tableList.add(fileContent.substring(startPosList.get(i),endPosList.get(i)));
        }
        return  tableList;
    }

    private static int getEndPos(String content,int pos){
        String substring = content.substring(pos);
        Matcher matcher = endPattern.matcher(substring);
        if (matcher.find()){
            return matcher.end();
        }
        return -1;
    }
    private static int getEndPos(String content){
        Matcher matcher = endPattern.matcher(content);
        if (matcher.find()){
            return matcher.end();
        }
        return -1;
    }

    private static List<Integer> getEndPosList(String fileContent){
        Matcher matcher = endPattern.matcher(fileContent);
        List<Integer> endPosList = new ArrayList<>(16);
        while (matcher.find()){
            endPosList.add(matcher.end());
        }
        return endPosList;
    }

    private static List<Integer> getStartPosList(String fileContent){
        Matcher matcher = startPattern.matcher(fileContent);
        List<Integer> startPosList = new ArrayList<>(16);
        while (matcher.find()){
            startPosList.add(matcher.start());
        }
        return startPosList;
    }

    private static List<String> splitLines(String content){
        List<String> lines = new ArrayList<>(16);
        String wrap = "\r\n";
        int start = 0;
        int lineEnd;
        while((lineEnd = content.indexOf(wrap,start)) != NOT_FOUND){
            lineEnd += wrap.length();
            lines.add(content.substring(start,lineEnd));
            start = lineEnd+1;
        }
        lines.add(content.substring(start));
        return lines;
    }

    private static Table getTableInfo(List<String> tableInfoLines){
        Table table = new Table();
        String tableName = getTableName(tableInfoLines.get(0));
        table.setTableName(tableName);
        String tableEndRow = tableInfoLines.get(tableInfoLines.size()-1);
        table.setAutoIncreament(getAutoIncreament(tableEndRow));
        table.setEngine(getTableEngine(tableEndRow));
        table.setCharset(getTableCharset(tableEndRow));
        table.setComment(getTableComment(tableEndRow));
        //下面仅对 创建语句中间部分进行处理
        tableInfoLines.remove(tableInfoLines.size()-1);
        tableInfoLines.remove(0);
        List<Row> rowList = new ArrayList<>(tableInfoLines.size());
        table.setRowList(rowList);
        for (String rowString : tableInfoLines) {
//            System.out.println(rowString);
            if (!rowString.contains(Constants.keyFlag)){
                Row rowInfo = getRowInfo(rowString);
                rowList.add(rowInfo);
            }else{
                if (rowString.contains(primaryKeyStartFlag)){
                    List<String> primaryKeys = getPrimaryKeys(rowString);
                    table.setPrimaryKeyRowNameList(primaryKeys);
                }else{
                    TableIndex tableIndex = getTableIndex(rowString);
                    table.getTableIndexList().add(tableIndex);
                }
            }
        }
        return table;
    }



    //分析Table信息
    private static String getTableName(String firstRowString){
        final String flag = "`";
        String substring = firstRowString.substring(firstRowString.indexOf(flag)+flag.length(), firstRowString.lastIndexOf(flag));
        if (substring.isEmpty()){
            System.out.println("\n无法找到表格名字\n");
            throw new NotSupportFileException();
        }
        return substring;
    }

    private static String getTableCharset(String endRowString){
        final String tableCharsetStartFlag = "CHARSET";
        return getTargetStringByRegex(endRowString,
                tableCharsetStartFlag, Constants.CommentStartFlag, "[^a-zA-Z0-9]");
    }

    private static String getTableEngine(String endRowString){
        final String tableEngineStartFlag = "ENGINE";
        String engine = getTargetStringByRegex(endRowString, tableEngineStartFlag, SEPERATOR, "[^a-zA-Z0-9]");
        for (String supportEngine : Constants.supportEngines) {
            if (supportEngine.equalsIgnoreCase(engine)) return supportEngine;
        }
        throw new NotSupportEngine(engine);
    }


    private static String getTableComment(String endRowString){
        final String tableCommentFirstStartFlag = "COMMENT";
        final String tableCommentFlag = "'";
        int flag = endRowString.indexOf(tableCommentFirstStartFlag);
        if (flag == NOT_FOUND) return "";
        String substring = endRowString.substring(flag + tableCommentFirstStartFlag.length());
        return getTargetString(substring, tableCommentFlag, tableCommentFlag);
    }

    private static Long getAutoIncreament(String endRowString){
        final String autoIncreamentStartFlag = "AUTO_INCREMENT";
        int start = endRowString.indexOf(autoIncreamentStartFlag);
        if (start == NOT_FOUND) return null;
        String substring = endRowString.substring(start + autoIncreamentStartFlag.length());
        int pos = 0;
        //跳过非数字，直至找到数字
        while(true){
            char c = substring.charAt(pos);
            if (c >='0' && c<='9') break;
            pos++;
        }
        StringBuilder num = new StringBuilder(4);
        while(true){
            char c = substring.charAt(pos);
            if (c >='0' && c<='9'){
                num.append(c);
                pos++;
            } else {
                break;
            }
        }
        return Long.valueOf(num.toString());
    }

    private static List<String> getPrimaryKeys(String rowString){
        int beginIndex = rowString.indexOf(primaryKeyStartFlag);
        if (beginIndex == NOT_FOUND){
            throw new NotSupportFileException();
        }
        int end = rowString.indexOf(primaryKeyEndFlag, beginIndex + primaryKeyStartFlag.length());
        if (end == NOT_FOUND){
            throw new NotSupportFileException();
        }
        String substring = rowString.substring(beginIndex + primaryKeyStartFlag.length(), end);
        String[] split = substring.split(",");
        List<String> arrayList = new ArrayList<>(split.length);
        for (String s : split) {
            arrayList.add(s.trim());
        }
        return arrayList;
    }

    private static TableIndex getTableIndex(String rowString){
        final String indexRowStartFlag = "(`";
        final String indexRowEndFlag = "`)";
        TableIndex tableIndex = new TableIndex();
        tableIndex.setIndexName(getIndexName(rowString));
        tableIndex.setIndexType(getIndexType(rowString));
        tableIndex.setIndexMethod(getIndexMethod(rowString));
        String targetString = getTargetString(rowString, indexRowStartFlag, indexRowEndFlag);
        String[] split = targetString.split("`,`");
        List<String> rowList = new ArrayList<>(split.length);
        for (String s : split) {
            rowList.add(s.trim());
        }
        tableIndex.setRowList(rowList);
        return tableIndex;
    }

    private static IndexMethod getIndexMethod(String rowString){
        final String indexMethodFlag = String.format("USING%s",SEPERATOR);
        int start = rowString.indexOf(indexMethodFlag);
        if (start == NOT_FOUND) return IndexMethod.NONE;
        String endPart = rowString.substring(start + indexMethodFlag.length());
        if (endPart.contains(IndexMethod.BTREE.getIndexMethod())) return IndexMethod.BTREE;
        return IndexMethod.HASH;
    }

    private static IndexType getIndexType(String rowString){
        if (rowString.contains(IndexType.FULL_TEXT.getIndexType())) {
            return IndexType.FULL_TEXT;
        }
        if (rowString.contains(IndexType.UNIQUE.getIndexType())) {
            return IndexType.UNIQUE;
        }
        //这个必须放在最后，因为它的特征前面两种都符合
        return IndexType.NORMAL;
    }

    private static String getIndexName(String rowString){
        final String indexNameStartFlag = String.format("KEY%s`",SEPERATOR);
        final String indexNameEndFlag = "`";
        return getTargetString(rowString,indexNameStartFlag, indexNameEndFlag);
    }

    //分析Row部分
    private static Row getRowInfo(String rowString){
        Row row = new Row();
        row.setRowName(getRowName(rowString));
        row.setComment(getRowComment(rowString));
        DataType rowDataType = getRowDataType(rowString);
        row.setDataType(rowDataType);
        row.setTimeIsUpdateWhenModify(getRowTimeIsUpdateWhenModify(rowString));
        row.setDefaultValue(getRowDefaultValue(rowString));
        row.setNullAble(isNullAble(rowString));
        row.setLength(getLength(rowString,rowDataType));
        if (rowDataType == DataType.DECIMAL || rowDataType == DataType.DECIMAL_UNSIGNED){
            row.setDecimalLength(getDecimalLength(rowString,rowDataType));
        }else{
            row.setDecimalLength(null);
        }
        row.setUnsigned(isUnsigned(rowString));
        row.setAutoIncrease(isRowAutoIncrease(rowString));
        return row;
    }
    private static String getRowName(String rowString){
        final String flag = "`";
        int start = rowString.indexOf(flag) + flag.length();
        String substring = rowString.substring(start, rowString.indexOf(flag,start));
        if (substring.isEmpty()){
            System.out.println("\n无法找到字段名\n");
            throw new NotSupportFileException();
        }
        return substring;
    }

    private static boolean getRowTimeIsUpdateWhenModify(String rowString){
        return rowString.contains(timeIsUpdateWhenModify);
    }

    /**
     * 第二个 ` 的位置 至 第一个不是字母的 位置
     * @param rowString
     * @return
     */
    private static DataType getRowDataType(String rowString){
        final char flag = '`';
        int first = rowString.indexOf(flag) ;
        int second = rowString.indexOf(flag, first+1);
        int begin = second +1;
        //去掉空格
        String target = rowString.substring(begin).trim();
        StringBuilder dataType = new StringBuilder(8);
        int pos = 0;
        while(true){
            char c = target.charAt(pos);
            if (!(c>= 'A' && c<='z')){
                break;
            }
            pos ++;
            dataType.append(c);
        }
        DataType instance = DataType.getInstance(dataType.toString());
        if (instance == null){
            throw new NotSupportFileException("不支持的数据类型："+dataType.toString());
        }
        return instance;
    }

    private static Integer getLength(String rowString,DataType dataType){
        String endFlag = intLengthEndFlag;
        if (dataType == DataType.DECIMAL || dataType == DataType.DECIMAL_UNSIGNED){
            endFlag = decimalIntPartLengthEndFlag;
        }
        String jdbcName = dataType.getJdbcName();
        int pos = rowString.toUpperCase().indexOf(jdbcName.toUpperCase());
        assert pos != NOT_FOUND;
        int seperatorPos = rowString.indexOf(SEPERATOR, pos + jdbcName.length());
        int start = rowString.indexOf(lengthStartFlag, pos + jdbcName.length());
        //如果比跟在数据类型后面的一个空格还后，说明也没有长度
        if (start == NOT_FOUND || start>seperatorPos){
            //没有长度的数据类型
            return null;
        }else{
            int end = rowString.indexOf(endFlag, start + 1);
            return Integer.valueOf(rowString.substring(start+1,end));
        }
    }

    private static Integer getDecimalLength(String rowString,DataType dataType){
        String flag = dataType.getJdbcName();
        int begin = rowString.indexOf(flag);
        assert begin != NOT_FOUND;
        String targetString = getTargetString(rowString.substring(begin + flag.length()), decimalSecondPartLengthStartFlag, decimalSecondPartLengthEndFlag);
        return Integer.valueOf(targetString);
    }
    private static boolean isNullAble(String rowString){
        String flag = String.format("NOT%sNULL",SEPERATOR);
        return !rowString.contains(flag);
    }

    private static String getRowComment(String rowString) {
        String startFlag = String.format("COMMENT%s'", SEPERATOR);
        String endFlag = "',";
        return getTargetString(rowString, startFlag, endFlag);
    }


    private static boolean isUnsigned(String rowString){
        final String unsignedFlag = "unsigned";
        return rowString.contains(unsignedFlag);
    }

    private static String getRowDefaultValue(String rowString){
        final String defaultValueStartFlag = String.format("DEFAULT%s",SEPERATOR);
        String defaultValueEndFlag = SEPERATOR;
        if (!rowString.contains(CommentStartFlag)){
            defaultValueEndFlag = ",";
        }
        if (!rowString.contains(",")){
            defaultValueEndFlag = "\r\n";
        }
        if (!rowString.contains(defaultValueStartFlag)) return null;
        return getTargetString(rowString,defaultValueStartFlag,defaultValueEndFlag);
    }

    private static boolean isRowAutoIncrease(String rowString){
        return rowString.contains(Constants.rowAutoIncreaseFlag);
    }

    //常用方法
    //tableEndFlag 如果有，只会取最后一个
    private static String getTargetString(String rowString,char startFlag,char endFlag){
        return getTargetString(rowString,startFlag+"",endFlag+"");
    }

    private static String getTargetString(String rowString,String startFlag,String endFlag){
        return getTargetString(rowString,startFlag,0,endFlag);
    }
    private static String getTargetString(String rowString,String startFlag,int fromIndex,String endFlag){
        int start = rowString.indexOf(startFlag,fromIndex);
        if (start == NOT_FOUND){
            return "";
        }
        int end = rowString.indexOf(endFlag, start + startFlag.length());
        if (end == NOT_FOUND){
            throw new NotSupportFileException();
        }
        return rowString.substring(start+startFlag.length(),end).trim();
    }

    private static String getTargetStringByRegex(String content,String startFlag,String endFlag,String regexOfToRemoveStr){
        int flag = content.indexOf(startFlag);
        if (flag ==NOT_FOUND) return null;
        String endPart = content.substring(flag + startFlag.length());
        int commentPos = endPart.indexOf(endFlag);
        if (commentPos != NOT_FOUND){
            endPart = endPart.substring(0,commentPos);
        }
        return endPart.replaceAll(regexOfToRemoveStr, "").trim();
    }

}
