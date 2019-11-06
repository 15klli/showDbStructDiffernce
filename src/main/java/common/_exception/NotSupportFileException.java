package common._exception;

/**
 * @file: common._exception.NotSupportFileException
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/2 11:01

 */

public class NotSupportFileException extends RuntimeException {
    private static final long serialVersionUID = 4937408734482951160L;

    public NotSupportFileException() {
        this("不支持的文件类型，请使用Navicat导出的原生sql文件");
    }

    public NotSupportFileException(String message) {
        super(message);
    }

    public NotSupportFileException(String message, Throwable cause) {
        super(message, cause);
    }

    public NotSupportFileException(Throwable cause) {
        super(cause);
    }

    public NotSupportFileException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
