package model;

import _enum.IndexMethod;
import _enum.IndexType;
import util.ListUtils;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TableIndex that = (TableIndex) o;

        if (!indexName.equals(that.indexName)) return false;
        if (!ListUtils.equalsListIgnoreOrder(rowList,that.rowList)) return false;
        if (indexType != that.indexType) return false;
        return indexMethod == that.indexMethod;
    }

    @Override
    public int hashCode() {
        int result = indexName.hashCode();
        result = 31 * result + rowList.hashCode();
        result = 31 * result + indexType.hashCode();
        result = 31 * result + indexMethod.hashCode();
        return result;
    }
}
