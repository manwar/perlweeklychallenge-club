public class Ch1 {
  public static void main(String[] args) {
    System.out.println(good_integer(12344456));
    System.out.println(good_integer(1233334));
    System.out.println(good_integer(10020003));
  }

  private static String good_integer(int digit) {
    String s = String.valueOf(digit);
    char prev = Character.MIN_VALUE;
    int seen = 0;
    for (int i = 0; i < s.length(); ++i) {
      if (prev == s.charAt(i)) seen++;
      else if(seen == 3) return String.valueOf(prev).repeat(3);
      else {
        prev = s.charAt(i);
        seen = 1;
      }
    }
    return "-1";
  }
}
