public class Ch1 {
  public static void main(String[] args) {
    System.out.println(
      ones_and_zeros(new String[]{"10", "0001", "111001", "1", "0"}, 5, 3));
    System.out.println(ones_and_zeros(new String[]{"10", "1", "0"}, 1, 1));
  }

  private static int ones_and_zeros(String[] arr, int x, int y) {
    int[][] f = new int[x + 1][y + 1];
    for (String s : arr) {
      int[] cnt = count(s);
      for (int i = x; i >= cnt[0]; --i)
        for (int j = y; j >= cnt[1]; --j)
          f[i][j] = Math.max(f[i][j], f[i - cnt[0]][j - cnt[1]] + 1);
    }
    return f[x][y];
  }

  private static int[] count(String s) {
    int[] cnt = new int[2];
    for (int i = 0; i < s.length(); ++i) ++cnt[s.charAt(i) - '0'];
    return cnt;
  }
}
