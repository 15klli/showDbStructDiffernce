package common._exception;

/**
 * @file: common._exception.ComparingException
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 9:28
 * @Company: www.xyb2b.com
 */

public class ComparingException extends RuntimeException {
    private static final long serialVersionUID = 5272220079844291386L;

    public ComparingException(String table1,String table2) {
        this(String.format("对比两个表格时发生错误：%s 与 %s",table1,table2));
    }

    public ComparingException(String message) {
        super(message);
    }

    public ComparingException(String message, Throwable cause) {
        super(message, cause);
    }

    public ComparingException(Throwable cause) {
        super(cause);
    }

    public ComparingException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
