package _enum;

import common.Constants;
import sun.applet.Main;

/**
 * @file: _enum.IndexType
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/2 14:25
 * @Company: www.xyb2b.com
 */

public enum IndexType {
    NORMAL(0,"KEY"),
    UNIQUE(1,String.format("UNIQUE%sKEY", Constants.SEPERATOR)),
    FULL_TEXT(2,String.format("FULLTEXT%sKEY",Constants.SEPERATOR)),
    ;

    private final int code;
    private final String indexType;

    IndexType(int code, String indexType) {
        this.code = code;
        this.indexType = indexType;
    }

    public int getCode() {
        return code;
    }

    public String getIndexType() {
        return indexType;
    }

    public static IndexType getInstance(String indexType) {
        for (IndexType type : values()) {
            if (type.indexType.equalsIgnoreCase(indexType))
                return type;
        }
        return null;
    }
}
