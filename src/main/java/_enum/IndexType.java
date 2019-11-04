package _enum;

import common.Constants;

/**
 * @file: _enum.IndexType
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/2 14:25
 * @Company: www.xyb2b.com
 */

public enum IndexType {
    NORMAL(0,"KEY", ""),
    UNIQUE(1,String.format("UNIQUE%sKEY", Constants.SEPERATOR), "UNIQUE"),
    FULL_TEXT(2,String.format("FULLTEXT%sKEY",Constants.SEPERATOR), "FULLTEXT"),
    ;

    private final int code;
    private final String indexType;
    private final String indexName;

    IndexType(int code, String indexType, String indexName) {
        this.code = code;
        this.indexType = indexType;
        this.indexName = indexName;
    }

    public int getCode() {
        return code;
    }

    public String getIndexType() {
        return indexType;
    }

    public String getIndexName() {
        return indexName;
    }

    public static IndexType getInstance(String indexType) {
        for (IndexType type : values()) {
            if (type.indexType.equalsIgnoreCase(indexType))
                return type;
        }
        return null;
    }
}
