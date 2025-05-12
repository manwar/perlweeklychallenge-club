import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(distinct_average(new int[]{1, 2, 4, 3, 5, 6}));
    System.out.println(distinct_average(new int[]{0, 2, 4, 8, 3, 5}));
    System.out.println(distinct_average(new int[]{7, 3, 1, 0, 5, 9}));
  }

  private static int distinct_average(int[] arr) {
    Arrays.sort(arr);
    Set<Integer> s = new HashSet<>();
    for (int i = 0; i < arr.length / 2; ++i)
      s.add(arr[i] + arr[arr.length - i - 1]);
    return s.size();
  }
}

