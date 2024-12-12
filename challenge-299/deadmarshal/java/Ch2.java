public class Ch2 {
  private static final int[][] dir = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}};

  public static void main(String[] args) {
    char[][] a1 = new char[][]{{'A', 'B', 'D', 'E'}, {'C', 'B', 'C', 'A'},
      {'B', 'A', 'A', 'D'}, {'D', 'B', 'B', 'C'}};
    char[][] a2 = new char[][]{{'A', 'A', 'B', 'B'}, {'C', 'C', 'B', 'A'},
      {'C', 'A', 'A', 'A'}, {'B', 'B', 'B', 'B'}};
    char[][] a3 = new char[][]{{'B', 'A', 'B', 'A'}, {'C', 'C', 'C', 'C'},
      {'A', 'B', 'A', 'B'}, {'B', 'B', 'A', 'A'}};
    System.out.println(word_search(a1, "BDCA"));
    System.out.println(word_search(a2, "ABAC"));
    System.out.println(word_search(a3, "CCCAA"));
  }

  private static boolean word_search(char[][] chars, String str) {
    boolean[][] visited = new boolean[chars.length][chars[0].length];
    for (int i = 0; i < chars.length; ++i) {
      for (int j = 0; j < chars[i].length; ++j)
        if (word_search(chars, visited, str, 0, i, j)) return true;
    }
    return false;
  }

  private static boolean word_search(char[][] chars, boolean[][] visited,
                                     String word, int index, int x, int y) {
    if (index == word.length() - 1) return chars[x][y] == word.charAt(index);
    if (chars[x][y] == word.charAt(index)) {
      visited[x][y] = true;
      for (int i = 0; i < dir.length; ++i) {
        int nx = x + dir[i][0];
        int ny = y + dir[i][1];
        if ((is_inside(chars, nx, ny)) && (!visited[nx][ny]) && (word_search(
          chars, visited, word, index + 1, nx, ny))) return true;
      }
      visited[x][y] = false;
    }
    return false;
  }

  private static boolean is_inside(char[][] chars, int x, int y) {
    return x >= 0 && x < chars.length && y >= 0 && y < chars[0].length;
  }
}

