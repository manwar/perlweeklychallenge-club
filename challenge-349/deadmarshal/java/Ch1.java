public class Ch1 {
  public static void main(String[] args) {
    System.out.println(power_string("textbook"));
    System.out.println(power_string("aaaaa"));
    System.out.println(power_string("hoorayyy"));
    System.out.println(power_string("x"));
    System.out.println(power_string("aabcccddeeffffghijjk"));
  }

  private static int power_string(String s) {
    int res = 1, temp = 1;
    for(int i = 1; i < s.length(); ++i) {
      if(s.charAt(i) == s.charAt(i-1)) res = Math.max(res,++temp);
      else temp = 1;
    }
    return res;
  }
}

