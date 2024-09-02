public class Ch2 {
  public static void main(String[] args) {
    System.out.println(making_change(9));
    System.out.println(making_change(15));
    System.out.println(making_change(100));
  }

  private static int making_change(int amount) {
    int[] coins = {1, 5, 10, 25, 50};
    int[] dp = new int[amount+1];
    dp[0] = 1;
    for (int coin : coins)
      for (int i = coin; i <= amount; ++i) dp[i] += dp[i - coin];
    return dp[amount];
  }
}
