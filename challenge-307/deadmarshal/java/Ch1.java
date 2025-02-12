import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(check_order(new int[]{5, 2, 4, 3, 1}));
    System.out.println(check_order(new int[]{1, 2, 1, 1, 3}));
    System.out.println(check_order(new int[]{3, 1, 3, 2, 3}));
  }

  private static List<Integer> check_order(int[] arr) {
    List<Integer> ret = new ArrayList<>();
    int[] sorted = Arrays.copyOf(arr, arr.length);
    Arrays.sort(sorted);
    for (int i = 0; i < sorted.length; ++i) {
      if (sorted[i] != arr[i]) ret.add(i);
    }
    return ret;
  }
}
