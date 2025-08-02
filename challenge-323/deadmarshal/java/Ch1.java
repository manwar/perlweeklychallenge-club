public class Ch1 {
  public static void main(String[] args) {
    System.out.println(increment_decrement(new String[]{"--x", "x++", "x++"}));
    System.out.println(increment_decrement(new String[]{"x++", "++x", "x++"}));
    System.out.println(increment_decrement(new String[]{"x++", "++x", "--x", "x--"}));
  }

  private static int increment_decrement(String[] arr) {
    int x = 0;
    for (String s : arr) {
      if (s.contains("++")) x++;
      else x--;
    }
    return x;
  }
}
