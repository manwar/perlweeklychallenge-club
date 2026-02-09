public class Ch2 {
  public static void main(String[] args) {
    System.out.println(string_reduction("aabbccdd"));
    System.out.println(string_reduction("abccba"));
    System.out.println(string_reduction("abcdef"));
    System.out.println(string_reduction("aabbaeaccdd"));
    System.out.println(string_reduction("mississippi"));
  }
  
  private static String string_reduction(String s) {
    StringBuilder res = new StringBuilder();

    for(int i = 0; i < s.length(); ++i) {
      char c = s.charAt(i);
      int len = res.length();
      if(len > 0 && res.charAt(len-1) == c) {
	res.deleteCharAt(len-1);
      } else {
	res.append(c);
      }
    }

    return res.toString();
  }
}

