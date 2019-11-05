package util;

import common.Constants;
import model.Row;
import model.Table;
import model.TableIndex;

import java.util.*;
import java.util.stream.Collectors;

import static common.Constants.SQL_END_APPEND;
import static common.Constants.WRAP_STRING;

/**
 * @file: util.Generator
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 11:56
 * @Company: www.xyb2b.com
 */

public class Generator {

    private List<Table> fromTableList;

    private List<Table> toTableList;

    private StringBuilder alterOrAddSqlStringBuilder;
    private StringBuilder deleteOrRenameSqlStringBuilder;

    public Generator(List<Table> fromTableList, List<Table> toTableList) {
        this.fromTableList = fromTableList;
        this.toTableList = toTableList;
        alterOrAddSqlStringBuilder = new StringBuilder();
        deleteOrRenameSqlStringBuilder = new StringBuilder();
    }

    public String generate(){
        Map<String,Table> toTableMap = toTableList.stream().collect(Collectors.toMap(Table::getTableName,table -> table));
        Map<String,Table> fromTableMap = fromTableList.stream().collect(Collectors.toMap(Table::getTableName,table -> table));
        //处理表名没变化的表格中的行：增加、修改
        //以及增加已有的行
        //字符集/表格注释的更改
        toTableList.forEach(toTable ->{
            if (!fromTableMap.keySet().contains(toTable.getTableName())) {
                //如果之前的表格不包含 后来的表格，则增加
                alterOrAddSqlStringBuilder.append(toTable.getCreateSql()).append(SQL_END_APPEND);
            } else {
                //如果包含，则对比Row
                Table fromTable = fromTableMap.get(toTable.getTableName());
                Map<String,Row> toRowMap = new HashMap<>();
                Map<String,Row> fromRowMap = new HashMap<>();
                toTable.getRowList().forEach(row -> toRowMap.put(row.getRowName(),row));
                fromTable.getRowList().forEach(row -> fromRowMap.put(row.getRowName(),row));
                StringBuilder builder = new StringBuilder();
                toTable.getRowList().forEach(toRow ->{
                    //只处理能找到的
                    Row fromRow = fromRowMap.get(toRow.getRowName());
                    if (fromRow ==null){
                        //不存在就添加
                        builder.append(SqlFactory.getAddRowSql(toRow)).append(SQL_END_APPEND);
                    }else{
                        if (!toRow.equals(fromRow)) {//不相等说明有改动，就修改
                            builder.append(SqlFactory.getModifyRowSql(toRow)).append(SQL_END_APPEND);
                        }
                        //如果全部相等,不做操作
                    }
                });
                //对比主键部分
                if (!toTable.equalsPrimaryKeyList(fromTable.getPrimaryKeyRowNameList())){
                    builder.append(SqlFactory.getPrimaryKeyChangeString(toTable)).append(SQL_END_APPEND);
                }
                //对比索引部分
                List<TableIndex> toTableIndexList = toTable.getTableIndexList();
                List<TableIndex> fromTableIndexList = fromTable.getTableIndexList();
                if (!ListUtils.equalsListIgnoreOrder(toTableIndexList,fromTableIndexList)){
                    //索引的修改，是通过删除旧的索引，然后增加新的索引实现的
                    //因此一删一增，就拿到最新的了
                    fromTableIndexList.forEach(fromIndex ->{
                        if (!toTable.isTableIndexListContains(fromIndex)){
                            //如果后来的表格没有了，就删除
                            builder.append(SqlFactory.getDropIndexString(fromIndex)).append(SQL_END_APPEND);
                        }
                    });
                    toTableIndexList.forEach(toIndex ->{
                        if (!fromTable.isTableIndexListContains(toIndex)){
                            //如果之前的表格没有，就增加
                            builder.append(SqlFactory.getAddIndexString(toIndex)).append(SQL_END_APPEND);
                        }
                    });
                }
                //todo：支持引擎的修改
                //对比表格备注
                if (!toTable.getComment().trim().equalsIgnoreCase(fromTable.getComment().trim())){
                    builder.append(SqlFactory.getCommentChangeString(toTable.getComment())).append(SQL_END_APPEND);
                }
                //对比字符集
                if (!toTable.getCharset().trim().equalsIgnoreCase(fromTable.getCharset().trim())){
                    builder.append(SqlFactory.getCharsetChangeString(toTable.getCharset())).append(SQL_END_APPEND);
                }
                //添加句首和句尾
                if (builder.length()>0){
                    builder.insert(0,SqlFactory.getAlterTableSql(fromTable)+ WRAP_STRING);
                    String toDeleteString = SQL_END_APPEND;
                    int endPos = builder.length();
                    builder.delete(endPos-toDeleteString.length(),endPos).append(";");
                }
                alterOrAddSqlStringBuilder.append(builder).append(WRAP_STRING);
                //最后处理重命名情况
                checkRowRename(fromTable,toTable);
            }
        });

        //现在只处理不同项
        toTableList.forEach(toTable ->{
            if (fromTableMap.keySet().contains(toTable.getTableName())) toTableMap.remove(toTable.getTableName());
        });
        fromTableList.forEach(fromTable ->{
            if (toTableMap.keySet().contains(fromTable.getTableName())) fromTableMap.remove(fromTable.getTableName());
        });
        //处理字段重命名的情况


        //处理表格重命名的情况
        // 遍历对比不同的表格项，看看能否发现只是重命名的
        for (Table fromTable : fromTableMap.values()) {
            Iterator<Table> toTableIterator = toTableMap.values().iterator();
            while (toTableIterator.hasNext()) {
                Table toTable = toTableIterator.next();
                double similarity = PercentCalculateUtils.calTableSimilarity(fromTable, toTable);
                if (similarity >= Constants.TABLE_SAME_THRESHOLD) { //如果相似度超过阈值
                    deleteOrRenameSqlStringBuilder.append(SqlFactory.getDropTableTips(fromTable, toTable)).append(WRAP_STRING);
                    deleteOrRenameSqlStringBuilder.append(SqlFactory.getRenameTableSql(fromTable, toTable)).append(SQL_END_APPEND);
                    //外层的不用删除，因为一遍过后就不会再遍历了
                    checkRowRename(fromTable,toTable);
                    toTableIterator.remove();
                }
            }
        }
        return alterOrAddSqlStringBuilder.toString();
    }

    //对比Row之间的Rename
    private void checkRowRename(Table fromTable,Table toTable){
        //清除相同的
        List<Row> fromRowList = new ArrayList<>(fromTable.getRowList());
        List<Row> toRowList = new ArrayList<>(toTable.getRowList());
        for (Row fromRow : fromRowList) {
            if (toTable.indexRowByName(fromRow.getRowName()) == null) {
                Iterator<Row> toIterator = toRowList.iterator();
                while (toIterator.hasNext()) {
                    Row toRow = toIterator.next();
                    if (fromTable.indexRowByName(toRow.getRowName()) == null) {
                        double similarity = PercentCalculateUtils.calRowSimilarity(fromRow, toRow);
                        if (similarity >= Constants.ROW_SAME_THRESHOLD) {
                            if (toTable.getTableName().equalsIgnoreCase(fromTable.getTableName())) {
                                deleteOrRenameSqlStringBuilder.append(SqlFactory.getDropRowTipsInSameNameTable(fromTable, fromRow, toRow)).append(WRAP_STRING);
                            } else {
                                deleteOrRenameSqlStringBuilder.append(SqlFactory.getDropRowTipsInDifferentNameTable(fromTable, fromRow, toTable, toRow)).append(WRAP_STRING);
                            }
                            //删除刚才添加的重命名后的 row
                            deleteOrRenameSqlStringBuilder.append(SqlFactory.getAlterTableSql(toTable)).append(WRAP_STRING);
                            deleteOrRenameSqlStringBuilder.append(SqlFactory.getDropRowSql(toRow)).append(SQL_END_APPEND);
                            //然后加上重命名
                            deleteOrRenameSqlStringBuilder.append(SqlFactory.getRenameRowSql(fromRow, toRow)).append(SQL_END_APPEND);
                            //结束语句
                            changeTheEndOfSql(deleteOrRenameSqlStringBuilder);
                            //删除内层，不要重复对比，保证一个最多与一个表格匹配
                            toIterator.remove();
                        }
                    }
                }
            }
        }
    }

    private static StringBuilder changeTheEndOfSql(StringBuilder builder){
        String toDeleteString = SQL_END_APPEND;
        int endPos = builder.length();
        builder.delete(endPos-toDeleteString.length(),endPos).append(";");
        return builder;
    }
}
