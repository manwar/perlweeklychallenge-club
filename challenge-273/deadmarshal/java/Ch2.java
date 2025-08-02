public class Ch2 {
  public static void main(String[] args) {
    System.out.println(b_after_a("aabb"));
    System.out.println(b_after_a("abab"));
    System.out.println(b_after_a("aaa"));
    System.out.println(b_after_a("bbb"));
  }

  private static boolean b_after_a(String str) {
    int i = str.indexOf('b');
    return i != -1 && i >= str.lastIndexOf('a');
  }
}

