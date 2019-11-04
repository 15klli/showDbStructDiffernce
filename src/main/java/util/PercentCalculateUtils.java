package util;

import _exception.ComparingException;
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

    public static int calSimilarity(Table fromTable,Table toTable){
        if (fromTable.getTableName().trim().equalsIgnoreCase(toTable.getTableName().trim())){
            throw new ComparingException("表格名相同则视为相同");
        }

        return 0;
    }

}
