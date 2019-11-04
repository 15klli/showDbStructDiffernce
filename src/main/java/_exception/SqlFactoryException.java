package _exception;

/**
 * @file: _exception.SqlFactoryException
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 10:34
 * @Company: www.xyb2b.com
 */

public class SqlFactoryException extends RuntimeException {
    private static final long serialVersionUID = -1187694087300120781L;

    public SqlFactoryException() {
        this("");
    }

    public SqlFactoryException(String message) {
        super("获取sql语句时发生错误:"+message);
    }

    public SqlFactoryException(String message, Throwable cause) {
        super(message, cause);
    }

    public SqlFactoryException(Throwable cause) {
        super(cause);
    }

    public SqlFactoryException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
