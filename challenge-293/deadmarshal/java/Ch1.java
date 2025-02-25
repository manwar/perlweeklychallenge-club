import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(similar_dominos(
      new int[][]{{1, 3}, {3, 1}, {2, 4}, {6, 8}}));
    System.out.println(similar_dominos(
      new int[][]{{1, 2}, {2, 1}, {1, 1}, {1, 2}, {2, 2}}));
  }

  private static int similar_dominos(int[][] arr) {
    int sum = 0;
    Map<String, Integer> h = new HashMap<>();
    for (int i = 0; i < arr.length; ++i) Arrays.sort(arr[i]);
    for (int i = 0; i < arr.length; ++i) {
      StringBuilder sb = new StringBuilder(2);
      for (int j = 0; j < arr[i].length; ++j) sb.append(arr[i][j]);
      String s = sb.toString();
      h.merge(s, 1, Integer::sum);
    }
    for (int v : h.values()) if (v > 1) sum += v;
    return sum;
  }
}

