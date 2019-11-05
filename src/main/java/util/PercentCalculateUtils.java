package util;

import _exception.ComparingException;
import com.sun.org.apache.bcel.internal.generic.IF_ACMPEQ;
import model.Row;
import model.Table;

/**
 * @file: util.PercentCalculateUtils
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 20:25
 * @Company: www.xyb2b.com
 */

public class PercentCalculateUtils {

    //决定Table相似度的因素
    private static final double ROW_NAME_SAME_WEIGHT_WHEN_TABLE = 0.80;
    private static final double ROW_DATA_TYPE_SAME_WEIGHT_WHEN_TABLE = 0.10;
    private static final double ROW_COMMENT_SAME_WEIGHT_WHEN_TABLE = 0.10;
    //决定Row相似度的因素
    private static final double ROW_DATA_TYPE_SAME_WEIGHT_WHEN_ROW = 0.60;
    private static final double ROW_COMMENT_SAME_WEIGHT_WHEN_ROW = 0.40;

    public static double calTableSimilarity(Table fromTable,Table toTable){
        if (fromTable.getTableName().trim().equalsIgnoreCase(toTable.getTableName().trim())){
            throw new ComparingException("表格名相同则视为相同");
        }
        double totalSimilarity = 0.0 ;
        for (Row fromRow : fromTable.getRowList()) {
            double similarity = 0;
            Row toRow;
            if ((toRow = toTable.indexRowByName(fromRow.getRowName())) !=null){
                //只有字段名一样才有相似度，因为如果字段名跟表格名都不一样，基本无法进行相似度的判断。
                similarity += ROW_NAME_SAME_WEIGHT_WHEN_TABLE;
                if (toRow.getDataType() == fromRow.getDataType()) similarity += ROW_DATA_TYPE_SAME_WEIGHT_WHEN_TABLE;
                String toRowComment = toRow.getComment().trim().toUpperCase();
                String fromRowComment = fromRow.getComment().trim().toUpperCase();
                if (fromRowComment.contains(toRowComment) || toRowComment.contains(fromRowComment)) totalSimilarity += ROW_COMMENT_SAME_WEIGHT_WHEN_TABLE;
            }
            totalSimilarity +=similarity;
        }
        return totalSimilarity / fromTable.getRowList().size();
    }

    public static double calRowSimilarity(Row fromRow,Row toRow){
        if (fromRow.getRowName().trim().equalsIgnoreCase(toRow.getRowName().trim())){
            throw new ComparingException("字段名相同则视为相同");
        }
        double totalSimilarity = 0.0 ;
        //todo：根据类型的 相似度？
        if (fromRow.getDataType() == toRow.getDataType()) totalSimilarity += ROW_DATA_TYPE_SAME_WEIGHT_WHEN_ROW;
        String toRowComment = toRow.getComment().trim().toUpperCase();
        String fromRowComment = fromRow.getComment().trim().toUpperCase();
        //todo:使用字符串相似度算法 https://blog.csdn.net/wangyangzhizhou/article/details/80660162
        if (fromRowComment.contains(toRowComment) || toRowComment.contains(fromRowComment)) totalSimilarity += ROW_COMMENT_SAME_WEIGHT_WHEN_ROW;
        return totalSimilarity;
    }

}
