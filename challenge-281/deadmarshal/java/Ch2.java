import java.util.LinkedList;
import java.util.Queue;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(knights_move("g2", "a8"));
    System.out.println(knights_move("g2", "h2"));
  }

  private static int knights_move(String start, String end) {
    assert start.length() == 2 && end.length() == 2;
    int[] s = new int[]{start.charAt(0) - 'a', start.charAt(1) - '0'};
    int[] e = new int[]{end.charAt(0) - 'a', end.charAt(1) - '0'};
    return min_steps(s, e, 8);
  }

  record Cell(int x, int y, int distance) {
  }

  private static boolean is_inside(int x, int y, int n) {
    return x >= 0 && x <= n && y >= 0 && y <= n;
  }

  private static int min_steps(int[] knight_pos, int[] target_pos, int n) {
    int[][] dirs =
      {{-2, 1}, {-1, 2}, {1, 2}, {2, 1}, {2, -1}, {1, -2}, {-1, -2}, {-2, -1}};
    Queue<Cell> q = new LinkedList<>();
    q.add(new Cell(knight_pos[0], knight_pos[1], 0));
    boolean[][] visited = new boolean[n + 1][n + 1];
    while (!q.isEmpty()) {
      Cell t = q.poll();
      if (t.x == target_pos[0] && t.y == target_pos[1]) return t.distance;
      for (int i = 0; i < n; ++i) {
        int x = t.x + dirs[i][0];
        int y = t.y + dirs[i][1];
        if (is_inside(x, y, n) && !visited[x][y]) {
          visited[x][y] = true;
          q.add(new Cell(x, y, t.distance + 1));
        }
      }
    }
    return Integer.MAX_VALUE;
  }
}
