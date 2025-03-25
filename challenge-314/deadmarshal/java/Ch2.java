public class Ch2 {
  public static void main(String[] args) {
    System.out.println(sort_column(new String[]{"swpc", "tyad", "azbe"}));
    System.out.println(sort_column(new String[]{"cba", "daf", "ghi"}));
    System.out.println(sort_column(new String[]{"a", "b", "c"}));
  }

  private static int sort_column(String[] strs) {
    int m = strs[0].length(), n = strs.length, ret = 0;
    for (int j = 0; j < m; ++j) {
      for (int i = 1; i < n; ++i) {
        if (strs[i].charAt(j) < strs[i - 1].charAt(j)) {
          ++ret;
          break;
        }
      }
    }
    return ret;
  }
}
