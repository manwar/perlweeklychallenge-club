import java.util.Arrays;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(max_diff(new int[] { 5, 9, 3, 4, 6 }));
    System.out.println(max_diff(new int[] { 1, -2, 3, -4 }));
    System.out.println(max_diff(new int[] { -3, -1, -2, -4 }));
    System.out.println(max_diff(new int[] { 10, 2, 0, 5, 1 }));
    System.out.println(max_diff(new int[] { 7, 8, 9, 10, 10 }));
  }

  private static int max_diff(int[] arr) {
    Arrays.sort(arr);
    final int n = arr.length;
    return arr[n - 1] * arr[n - 2] - arr[0] * arr[1];
  }
}
