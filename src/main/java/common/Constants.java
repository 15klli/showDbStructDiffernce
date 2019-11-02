package common;

import java.util.ArrayList;
import java.util.List;

/**
 * @file: common.Constants
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/2 15:15
 * @Company: www.xyb2b.com
 */

public class Constants {

    public static final String SEPERATOR = " ";
    public static final String CommentStartFlag = "COMMENT";
    public static final String keyFlag = "KEY";
    public static final List<String> supportEngines;
    public static final String primaryKeyStartFlag = String.format("PRIMARY%sKEY%s(`",SEPERATOR,SEPERATOR);
    public static final String primaryKeyEndFlag = "`)";
    public static final String rowAutoIncreaseFlag = "AUTO_INCREMENT";
    public static final String lengthStartFlag = "(";
    public static final String intLengthEndFlag = ")";
    public static final String decimalIntPartLengthEndFlag = ",";
    public static final String decimalSecondPartLengthStartFlag = ",";
    public static final String decimalSecondPartLengthEndFlag = ")";

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
