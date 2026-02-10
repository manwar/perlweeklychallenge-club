public class Ch1 {
  public static void main(String[] args) {
    try {
      System.out.println(textJustifier("Hi", 5));
      System.out.println(textJustifier("Code", 10));
      System.out.println(textJustifier("Hello", 9));
      System.out.println(textJustifier("Perl", 4));
      System.out.println(textJustifier("A", 7));
      System.out.println(textJustifier("", 5));
    } catch(Exception e) {
      System.err.println(e);
    }
  }

  private static String textJustifier(String str,int width)
    throws IllegalArgumentException {
    int diff = width - str.length();
    if(diff < 0) {
      throw new IllegalArgumentException("Length too short!");
    }
    int left = diff / 2;
    int right = diff - left;
    return "*".repeat(left) + str + "*".repeat(right);
  }
}

