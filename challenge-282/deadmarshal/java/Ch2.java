public class Ch2 {
  public static void main(String[] args) {
    System.out.println(changing_keys("pPeERrLl"));
    System.out.println(changing_keys("rRr"));
    System.out.println(changing_keys("GoO"));
  }

  private static int changing_keys(String s) {
    int c = 0;
    for (int i = 1; i < s.length(); ++i)
      if (Character.toLowerCase(s.charAt(i)) != Character.toLowerCase(
        s.charAt(i - 1))) c++;
    return c;
  }
}
