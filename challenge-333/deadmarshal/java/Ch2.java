import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    int[] a1 = new int[]{1, 0, 2, 3, 0, 4, 5, 0};
    int[] a2 = new int[]{1, 2, 3};
    int[] a3 = new int[]{1, 2, 3, 0};
    int[] a4 = new int[]{0, 0, 1, 2};
    int[] a5 = new int[]{1, 2, 0, 3, 4};
    for (var a : new int[][]{a1, a2, a3, a4, a5}) duplicate_zeros(a);
    System.out.println(Arrays.toString(a1));
    System.out.println(Arrays.toString(a2));
    System.out.println(Arrays.toString(a3));
    System.out.println(Arrays.toString(a4));
    System.out.println(Arrays.toString(a5));
  }

  private static void duplicate_zeros(int[] arr) {
    int n = arr.length, i = -1, k = 0;
    while (k < n) {
      ++i;
      k += arr[i] > 0 ? 1 : 2;
    }
    int j = n - 1;
    if (k == n + 1) {
      arr[j--] = 0;
      --i;
    }
    while (j >= 0) {
      arr[j] = arr[i];
      if (arr[i] == 0) arr[--j] = arr[i];
      --i;
      --j;
    }
  }
}
