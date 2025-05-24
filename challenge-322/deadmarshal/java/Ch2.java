import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(Arrays.toString(rank_array(new int[]{55, 22, 44, 33})));
    System.out.println(Arrays.toString(rank_array(new int[]{10, 10, 10})));
    System.out.println(Arrays.toString(rank_array(new int[]{5, 1, 1, 4, 3})));
  }

  private static int[] rank_array(int[] arr) {
    int n = arr.length;
    int[] t = arr.clone();
    Arrays.sort(t);
    int m = 0;
    for (int i = 0; i < n; ++i) {
      if ((i == 0) || (t[i] != t[i - 1])) t[m++] = t[i];
    }
    int[] ans = new int[n];
    for (int i = 0; i < n; ++i)
      ans[i] = Arrays.binarySearch(t, 0, m, arr[i]) + 1;
    return ans;
  }
}

