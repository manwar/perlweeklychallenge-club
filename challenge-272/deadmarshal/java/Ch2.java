public class Ch2 {
  public static void main(String[] args) {
    System.out.println(string_score("hello"));
    System.out.println(string_score("perl"));
    System.out.println(string_score("raku"));
  }

  private static int string_score(String str) {
    int sum = 0;
    for (int i = 0; i < str.length() - 1; ++i) {
      sum += Math.abs(str.charAt(i + 1) - str.charAt(i));
    }
    return sum;
  }
}

