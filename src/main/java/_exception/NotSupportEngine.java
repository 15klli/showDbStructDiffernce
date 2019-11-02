package _exception;

import common.Constants;

import java.util.List;
import java.util.regex.Pattern;

/**
 * @file: _exception.NotSupportEngine
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/2 16:33
 * @Company: www.xyb2b.com
 */

public class NotSupportEngine extends RuntimeException{

    private static final long serialVersionUID = -6293627900432456715L;
    private static final String supportEnginesString;

    static{
        List<String> supportEngines = Constants.supportEngines;
        StringBuilder builder = new StringBuilder(16);
        supportEngines.forEach(supportEngine ->{
            builder.append(supportEngine);
            builder.append(",");
        });
        supportEnginesString = "目前仅支持以下存储引擎：["+ builder.delete(builder.length()-1,builder.length()).toString()+"]";
    }

    public NotSupportEngine(String nowEngine) {
        super(supportEnginesString+"暂不支持此存储引擎："+nowEngine);
    }

    public NotSupportEngine(String message, Throwable cause) {
        super(message, cause);
    }

    public NotSupportEngine(Throwable cause) {
        super(cause);
    }

    public NotSupportEngine(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
