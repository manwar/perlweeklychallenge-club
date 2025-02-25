import java.util.ArrayList;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(binary_prefix(new int[]{1, 0, 1}));
    System.out.println(binary_prefix(new int[]{1, 1, 0}));
    System.out.println(binary_prefix(
      new int[]{1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1}));
  }

  private static boolean is_prime(int n) {
    if (n <= 1) return false;
    if ((n == 2) || (n == 3)) return true;
    if ((n % 2 == 0) || (n % 3 == 0)) return false;
    for (int i = 5; i < Math.sqrt(n); i += 6)
      if ((n % i == 0) || (n % (i + 2) == 0)) return false;
    return true;
  }

  private static List<Boolean> binary_prefix(int[] arr) {
    StringBuilder sb = new StringBuilder();
    List<Boolean> ret = new ArrayList<>();
    for (int i = 0; i < arr.length; ++i) {
      sb.append(arr[i]);
      ret.add(is_prime(Integer.parseInt(sb.toString(), 2)));
    }
    return ret;
  }
}
