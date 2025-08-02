import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(maximum_frequency(new int[]{1, 2, 2, 4, 1, 5}));
    System.out.println(maximum_frequency(new int[]{1, 2, 3, 4, 5}));
  }

  private static int maximum_frequency(int[] arr) {
    Map<Integer, Integer> hash = new HashMap<>();
    for (int e : arr) hash.put(e, hash.getOrDefault(e, 0) + 1);
    int max = Collections.max(hash.values());
    return (int) hash.keySet().stream()
      .filter(e -> hash.get(e) == max).count() * max;
  }
}
