public class Ch2 {
  public static void main(String[] args) {
    System.out.println(group_digit_sum("111122333", 3));
    System.out.println(group_digit_sum("1222312", 2));
    System.out.println(group_digit_sum("100012121001", 4));
  }

  private static String group_digit_sum(String str, int n) {
    while (str.length() > n) {
      StringBuilder sb = new StringBuilder();
      for (int i = 0; i < str.length(); i += n) {
        int x = 0;
        for (int j = i; j < Math.min(i + n, str.length()); ++j)
          x += str.charAt(j) - '0';
        sb.append(x);
      }
      str = sb.toString();
    }
    return str;
  }
}

