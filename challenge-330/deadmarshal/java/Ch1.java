public class Ch1 {
  public static void main(String[] args) {
    System.out.println(clear_digits("cab12"));
    System.out.println(clear_digits("xy99"));
    System.out.println(clear_digits("pa1erl"));
  }

  private static String clear_digits(String str) {
    String prev = str;
    do {
      prev = str;
      str = str.replaceAll("\\D\\d", "");
    } while (!str.equals(prev));
    return str;
  }
}

