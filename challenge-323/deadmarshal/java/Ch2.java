public class Ch2 {
  public static void main(String[] args) {
    System.out.println(tax_amount(10, new int[][]{{3, 50}, {7, 10}, {12, 25}}));
    System.out.println(tax_amount(2, new int[][]{{1, 0}, {4, 25}, {5, 50}}));
    System.out.println(tax_amount(0, new int[][]{{2, 50}}));
  }

  private static double tax_amount(int income, int[][] taxes) {
    int res = 0, prev = 0;
    for (var e : taxes) {
      res += Math.max(0, Math.min(income, e[0]) - prev) * e[1];
      prev = e[0];
    }
    return res / 100.0;
  }
}

