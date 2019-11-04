package _enum;

/**
 * @file: _enum.SupportedRowChangeMethod
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 10:39
 * @Company: www.xyb2b.com
 */

public enum SupportedRowChangeMethod {
    MODIFY(0,"MODIFY"),
    ADD(1,"ADD"),
    ;

    private final int code;
    private final String methodName;

    SupportedRowChangeMethod(int code, String methodName) {
        this.code = code;
        this.methodName = methodName;
    }

    public String getMethodName() {
        return methodName;
    }
}
