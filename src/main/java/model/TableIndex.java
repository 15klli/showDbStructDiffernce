package model;

import _enum.IndexMethod;
import _enum.IndexType;

import java.util.List;

/**
 * @file: model.TableIndex
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/2 14:24
 * @Company: www.xyb2b.com
 */

public class TableIndex {
    private String indexName;

    private List<String> rowList;

    private IndexType indexType;

    private IndexMethod indexMethod;

    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    public List<String> getRowList() {
        return rowList;
    }

    public void setRowList(List<String> rowList) {
        this.rowList = rowList;
    }

    public IndexType getIndexType() {
        return indexType;
    }

    public void setIndexType(IndexType indexType) {
        this.indexType = indexType;
    }

    public IndexMethod getIndexMethod() {
        return indexMethod;
    }

    public void setIndexMethod(IndexMethod indexMethod) {
        this.indexMethod = indexMethod;
    }

    @Override
    public String toString() {
        return "TableIndex{" +
                "indexName='" + indexName + '\'' +
                ", rowList=" + rowList +
                ", indexType=" + indexType +
                ", indexMethod=" + indexMethod +
                '}';
    }
}
