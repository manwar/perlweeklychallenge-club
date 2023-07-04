import java.util.Arrays;

public class Main {
  public static void main(String[] args) {
    int[] box = {3, 1, 5, 8};
    System.out.println(maxCoins(box)); // Outputs: 167
  }

  public static int maxCoins(int[] nums) {
    int n = nums.length;
    int[][] dp = new int[n + 2][n + 2];
    int[] val = new int[n + 2];
    val[0] = val[n + 1] = 1;
    System.arraycopy(nums, 0, val, 1, n);
    for (int len = 1; len <= n; len++) {
      for (int i = 1; i <= n - len + 1; i++) {
        int j = i + len - 1;
        for (int k = i; k <= j; k++) {
          dp[i][j] = Math.max(dp[i][j], dp[i][k - 1] +
                                            val[i - 1] * val[k] * val[j + 1] +
                                            dp[k + 1][j]);
        }
      }
    }
    return dp[1][n];
  }
}
