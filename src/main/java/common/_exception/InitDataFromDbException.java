package common._exception;

/**
 * @file: common._exception.InitDataFromDbException

 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/7 16:37
 * @Company: www.xyb2b.com
 */

public class InitDataFromDbException extends RuntimeException{
    private static final long serialVersionUID = 8614658231846491319L;

    public InitDataFromDbException() {
        this("从数据库读取数据时发生错误");
    }

    public InitDataFromDbException(String message) {
        super(message);
    }

    public InitDataFromDbException(String message, Throwable cause) {
        super(message, cause);
    }

    public InitDataFromDbException(Throwable cause) {
        super(cause);
    }

    public InitDataFromDbException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
