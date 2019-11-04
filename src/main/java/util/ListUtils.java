package util;

import java.util.ArrayList;
import java.util.List;

/**
 * @file: util.ListUtils
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/4 16:00
 * @Company: www.xyb2b.com
 */

public class ListUtils {

    public static <T> boolean equalsListIgnoreOrder(List<T> list1, List<T> list2) {
        if (list1.equals(list2)) return true;
        if (list1.size() != list2.size()) {
            return false;
        } else {
            for (T element : list1) {
                int flag = 0;
                for (T t : list2) {
                    if (t.equals(element)){
                        flag = 1;
                        break;
                    }
                }
                if (flag == 0 ) return false;
            }
            return true;
        }
    }

    public static void main(String[] args) {
        List<String> a = new ArrayList<>();
        a.add("a");
        a.add("b");
        List<String> b = new ArrayList<>();
        b.add("b");
        b.add("a");
        System.out.println(equalsListIgnoreOrder(a,b));
    }
}
