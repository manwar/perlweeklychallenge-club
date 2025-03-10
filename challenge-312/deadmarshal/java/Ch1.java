public class Ch1 {
  public static void main(String[] args) {
    System.out.println(minimum_time("abc"));
    System.out.println(minimum_time("bza"));
    System.out.println(minimum_time("zjpc"));
  }

  private static int minimum_time(String str) {
    int res = 0, prev = 0;
    for (char c : str.toCharArray()) {
      int curr = c - 'a';
      int t = Math.abs(prev - curr);
      t = Math.min(t, 26 - t);
      res += t + 1;
      prev = curr;
    }
    return res;
  }
}
