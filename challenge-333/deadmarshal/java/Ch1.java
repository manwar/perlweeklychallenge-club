public class Ch1 {
  public static void main(String[] args) {
    System.out.println(straight_line(new int[][]{{2, 1}, {2, 3}, {2, 5}}));
    System.out.println(straight_line(new int[][]{{1, 4}, {3, 4}, {10, 4}}));
    System.out.println(straight_line(new int[][]{{0, 0}, {1, 1}, {2, 3}}));
    System.out.println(straight_line(new int[][]{{1, 1}, {1, 1}, {1, 1}}));
    System.out.println(straight_line(new int[][]{{1000000, 1000000},
      {2000000, 2000000}, {3000000, 3000000}}));
  }

  private static boolean straight_line(int[][] arr) {
    int x1 = arr[0][0], y1 = arr[0][1], x2 = arr[1][0], y2 = arr[1][1];
    for (int i = 2; i < arr.length; ++i) {
      int x = arr[i][0], y = arr[i][1];
      if ((x - x1) * (y2 - y1) != (y - y1) * (x2 - x1)) return false;
    }
    return true;
  }
}