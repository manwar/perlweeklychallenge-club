import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(Arrays.toString(sort_even_odd(new int[]{4, 1, 2, 3})));
    System.out.println(Arrays.toString(sort_even_odd(new int[]{3, 1})));
    System.out.println(
      Arrays.toString(sort_even_odd(new int[]{5, 3, 2, 1, 4})));
  }

  private static int[] sort_even_odd(int[] arr) {
    int n = arr.length;
    int[] a = new int[(n + 1) >> 1];
    int[] b = new int[n >> 1];
    for (int i = 0, j = 0; j < n >> 1; i += 2, ++j) {
      a[j] = arr[i];
      b[j] = arr[i + 1];
    }
    if (n % 2 == 1) a[a.length - 1] = arr[n - 1];
    Arrays.sort(a);
    Arrays.sort(b);
    int[] ans = new int[n];
    for (int i = 0, j = 0; j < a.length; i += 2, ++j)
      ans[i] = a[j];
    for (int i = 1, j = b.length - 1; j >= 0; i += 2, --j)
      ans[i] = b[j];
    return ans;
  }
}
