public class Ch2 {
  public static void main(String[] args) {
    System.out.println(odd_matrix(2, 3, new int[][]{{0, 1}, {1, 1}}));
    System.out.println(odd_matrix(2, 2, new int[][]{{1, 1}, {0, 0}}));
    System.out.println(odd_matrix(3, 3, new int[][]{{0, 0}, {1, 2}, {2, 1}}));
    System.out.println(odd_matrix(1, 5, new int[][]{{0, 2}, {0, 4}}));
    System.out.println(odd_matrix(4, 2, new int[][]{{1, 0}, {3, 1}, {2, 0}, {0, 1}}));
  }

  private static int odd_matrix(int row, int col, int[][] m) {
    int res = 0;
    int[][] g = new int[row][col];
    for (int[] e : m) {
      int r = e[0], c = e[1];
      for (int i = 0; i < row; ++i) g[i][c]++;
      for (int j = 0; j < col; ++j) g[r][j]++;
    }
    for (int[] rows : g) {
      for (int v : rows) {
        res += v % 2;
      }
    }
    return res;
  }
}
