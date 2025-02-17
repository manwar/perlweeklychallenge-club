import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(min_diff(new int[]{1, 5, 8, 9}));
    System.out.println(min_diff(new int[]{9, 4, 1, 7}));
  }

  private static int min_diff(int[] arr) {
    Arrays.sort(arr);
    int min = Integer.MAX_VALUE, diff;
    for (int i = 1; i < arr.length; ++i) {
      diff = Math.abs(arr[i] - arr[i - 1]);
      if (diff < min) min = diff;
    }
    return min;
  }
}
