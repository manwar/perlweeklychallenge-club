public class Ch2 {
  public static void main(String[] args) {
    System.out.println(find_winner(new int[][]{{0, 0}, {2, 0},
      {1, 1}, {2, 1}, {2, 2}}));
    System.out.println(find_winner(new int[][]{{0, 0}, {1, 1}, {0, 1}, {0, 2}
      , {1, 0}, {2, 0}}));
    System.out.println(find_winner(new int[][]{{0, 0}, {1, 1}, {2, 0}, {1, 0},
      {1, 2}, {2, 1}, {0, 1}, {0, 2}, {2, 2}}));
    System.out.println(find_winner(new int[][]{{0, 0}, {1, 1}}));
    System.out.println(find_winner(new int[][]{{1, 1}, {0, 0}, {2, 2}, {0, 1},
      {1, 0}, {0, 2}}));
  }

  private static String find_winner(int[][] moves) {
    int[] cnt = new int[8];
    for (int k = moves.length - 1; k >= 0; k -= 2) {
      int i = moves[k][0], j = moves[k][1];
      cnt[i]++;
      cnt[j + 3]++;
      if (i == j) cnt[6]++;
      if (i + j == 2) cnt[7]++;
      if (cnt[i] == 3 || cnt[j + 3] == 3 || cnt[6] == 3 || cnt[7] == 3)
        return k % 2 == 0 ? "A" : "B";
    }
    return moves.length == 9 ? "Draw" : "Pending";
  }
}

