import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(consecutive_sequence(new int[]{10, 4, 20, 1, 3, 2}));
    System.out.println(
      consecutive_sequence(new int[]{0, 6, 1, 8, 5, 2, 4, 3, 0, 7}));
    System.out.println(consecutive_sequence(new int[]{10, 30, 20}));
  }

  private static int consecutive_sequence(int[] arr) {
    Set<Integer> s = Arrays.stream(arr).boxed().collect(Collectors.toSet());
    int res = 0, j;
    for (int e : arr) {
      if (!s.contains(e - 1)) {
        j = e;
        while (s.contains(j)) j++;
        res = Math.max(res, j - e);
      }
    }
    return res == 1 ? -1 : res;
  }
}

