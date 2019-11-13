package common._enum;

/**
 * @file: common._enum.indexMethod
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/2 14:27

 */

public enum IndexMethod {
    BTREE(0,"BTREE"),
    HASH(1,"HASH"),
    NONE(2,"")
    ;

    private final int code;
    private final String indexMethod;

    IndexMethod(int code, String indexMethod) {
        this.code = code;
        this.indexMethod = indexMethod;
    }

    public int getCode() {
        return code;
    }

    public String getIndexMethod() {
        return indexMethod;
    }

    public static IndexMethod getInstance(String indexMethod) {
        for (IndexMethod method : values()) {
            if (method.indexMethod.equalsIgnoreCase(indexMethod))
                return method;
        }
        return null;
    }
}
