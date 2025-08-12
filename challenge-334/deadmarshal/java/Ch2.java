public class Ch2 {
  public static void main(String[] args) {
    System.out.println(nearest_valid_point(new int[][]{{1, 2}, {3, 1}, {2, 4}, {2, 3}},
      3, 4));
    System.out.println(nearest_valid_point(new int[][]{{3, 4}, {2, 3}, {1, 5}, {2, 5}},
      2, 5));
    System.out.println(nearest_valid_point(new int[][]{{2, 2}, {3, 3}, {4, 4}},
      1, 1));
    System.out.println(nearest_valid_point(new int[][]{{0, 1}, {1, 0}, {0, 2}, {2, 0}},
      0, 0));
    System.out.println(nearest_valid_point(new int[][]{{5, 6}, {6, 5}, {5, 4}, {4, 5}},
      5, 5));
  }

  private static int nearest_valid_point(int[][] arr, int x, int y) {
    int res = -1, min = Integer.MAX_VALUE;
    for (int i = 0; i < arr.length; ++i) {
      int a = arr[i][0], b = arr[i][1];
      if (a == x || b == y) {
        int d = Math.abs(a - x) + Math.abs(b - y);
        if (d < min) {
          min = d;
          res = i;
        }
      }
    }
    return res;
  }
}

