import java.util.HashMap;
import java.util.Map;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(double_exist(new int[]{6, 2, 3, 3}));
    System.out.println(double_exist(new int[]{3, 1, 4, 13}));
    System.out.println(double_exist(new int[]{2, 1, 4, 2}));
  }

  private static boolean double_exist(int[] arr) {
    Map<Integer, Integer> h = new HashMap<>();
    for (int e : arr) h.put(e, 1);
    for (int k : h.keySet()) if (h.containsKey(k * 2)) return true;
    return false;
  }
}
