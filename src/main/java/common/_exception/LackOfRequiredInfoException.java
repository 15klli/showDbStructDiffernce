package common._exception;

/**
 * @file: common._exception.LackOfRequiredInfoException
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/7 14:05
 * @Company: www.xyb2b.com
 */

public class LackOfRequiredInfoException extends RuntimeException {
    private static final long serialVersionUID = -2391405966184204314L;

    public LackOfRequiredInfoException() {
        this("必填信息不完整！");
    }

    public LackOfRequiredInfoException(String message) {
        super("必填信息不完整！"+message+"缺失");
    }

    public LackOfRequiredInfoException(String message, Throwable cause) {
        super(message, cause);
    }

    public LackOfRequiredInfoException(Throwable cause) {
        super(cause);
    }

    public LackOfRequiredInfoException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
