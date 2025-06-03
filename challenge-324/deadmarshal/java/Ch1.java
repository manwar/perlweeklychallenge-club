import java.util.Arrays;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(Arrays.deepToString(twod_array(new int[]{1, 2, 3, 4}, 2, 2)));
    System.out.println(Arrays.deepToString(twod_array(new int[]{1, 2, 3}, 1, 3)));
    System.out.println(Arrays.deepToString(twod_array(new int[]{1, 2, 3, 4}, 4, 1)));
  }

  private static int[][] twod_array(int[] arr, int r, int c) {
    if (r * c != arr.length) return new int[0][0];
    int[][] res = new int[r][c];
    for (int i = 0; i < r; ++i) {
      for (int j = 0; j < c; ++j) {
        res[i][j] = arr[i * c + j];
      }
    }
    return res;
  }
}
