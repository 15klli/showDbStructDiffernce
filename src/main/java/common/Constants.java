package common;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 * @file: common.Constants
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/2 15:15

 */

public class Constants {

    public static final String SEPERATOR = " ";
    public static String SQL_END_APPEND = ";\r\n";
    public static String WRAP_STRING = "\r\n";
    public static String SQL_DISABLE = "--";
    private static final String tableEndFlag = String.format("CHARSET(%s)*=(%s)*[\\d\\D]*?;",SEPERATOR,SEPERATOR);
    private static final String tableStartFlag = String.format("CREATE(%s)*TABLE",SEPERATOR);
    public static Pattern endPattern = Pattern.compile(tableEndFlag);
    public static Pattern startPattern = Pattern.compile(tableStartFlag);
    public static final int NOT_FOUND= -1;
    public static final String CommentStartFlag = "COMMENT";
    public static final String keyFlag = "KEY";
    public static final List<String> supportEngines;
    public static final String primaryKeyStartFlag = String.format("PRIMARY%sKEY%s(`",SEPERATOR,SEPERATOR);
    public static final String primaryKeyEndFlag = "`)";
    public static final String rowAutoIncreaseFlag = "AUTO_INCREMENT";
    public static final String lengthStartFlag = "(";
    public static final String intLengthEndFlag = ")";
    public static final String unsignedFlag = "UNSIGNED";
    public static final String timeIsUpdateWhenModify = String.format("ON%sUPDATE%sCURRENT_TIMESTAMP",SEPERATOR,SEPERATOR);
    public static final String decimalIntPartLengthEndFlag = ",";
    public static final String decimalSecondPartLengthStartFlag = ",";
    public static final String decimalSecondPartLengthEndFlag = ")";
    public static final double TABLE_SAME_THRESHOLD = 0.8;
    public static final double ROW_SAME_THRESHOLD = 0.8;
    public static final String defaultSqlDirName = "src/main/resources/sqlDir";

    static  {
        supportEngines = new ArrayList<>(4);
        supportEngines.add("InnoDB");
    }

    public static void main(String[] args) {
        StringBuilder builder = new StringBuilder(16);
        supportEngines.forEach(supportEngine ->{
            builder.append(supportEngine);
            builder.append(",");
        });
        System.out.println(builder.delete(builder.length()-1,builder.length()).toString());
    }
}
