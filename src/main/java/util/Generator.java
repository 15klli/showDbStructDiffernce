package util;

import model.Row;
import model.Table;
import model.TableIndex;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

    private StringBuilder sqlStringBuilder;

    public Generator(List<Table> fromTableList, List<Table> toTableList) {
        this.fromTableList = fromTableList;
        this.toTableList = toTableList;
        sqlStringBuilder = new StringBuilder();
    }

    public String generate(){
        Map<String,Table> toTableMap = toTableList.stream().collect(Collectors.toMap(Table::getTableName,table -> table));
        Map<String,Table> fromTableMap = fromTableList.stream().collect(Collectors.toMap(Table::getTableName,table -> table));
        StringBuilder changeString = sqlStringBuilder;
        //寻找后来添加的表格
        toTableList.forEach(toTable ->{
            if (!fromTableMap.keySet().contains(toTable.getTableName())){
                //todo: 超过相同阈值，则提示
                sqlStringBuilder.append(toTable.getCreateSql()).append(WRAP_STRING);
            }
        });
        fromTableList.forEach(fromTable ->{
            if (!toTableMap.keySet().contains(fromTable.getTableName())){
                //如果后来的表格不包含 原来的表格，则删除
                sqlStringBuilder.append(SqlFactory.getDropTableSql(fromTable)).append(SQL_END_APPEND);
            }else{
                //如果包含，则对比Row
                Table toTable = toTableMap.get(fromTable.getTableName());
                Map<String,Row> toRowMap = new HashMap<>();
                Map<String,Row> fromRowMap = new HashMap<>();
                toTable.getRowList().forEach(row -> toRowMap.put(row.getRowName(),row));
                fromTable.getRowList().forEach(row -> fromRowMap.put(row.getRowName(),row));
                StringBuilder builder = new StringBuilder();
                toTable.getRowList().forEach(toRow ->{
                    Row fromRow = fromRowMap.get(toRow.getRowName());
                    if (fromRow ==null){
                        //不存在就添加
                        builder.append(SqlFactory.getAddRowSql(toRow)).append(SQL_END_APPEND);
                    }else{
                        if (!toRow.equals(fromRow)) {//不相等说明，就修改
                            builder.append(SqlFactory.getModifySql(toRow)).append(SQL_END_APPEND);
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
                    builder.insert(0,String.format("ALTER TABLE `%s`%s",toTable.getTableName(), WRAP_STRING));
                    String toDeleteString = SQL_END_APPEND;
                    int endPos = builder.length();
                    builder.delete(endPos-toDeleteString.length(),endPos).append(";");
                }
                changeString.append(builder).append(WRAP_STRING);
            }
        });
        return changeString.toString();
    }
}
