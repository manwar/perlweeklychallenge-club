public class Ch2 {
  public static void main(String[] args) {
    System.out.println(subsequence("uvw","bcudvew"));
    System.out.println(subsequence("aec","abcde"));
    System.out.println(subsequence("sip","javascript"));
  }

  private static boolean subsequence(String s1,String s2) {
    int i = 0, j = 0;
    while((i < s1.length()) && (j < s2.length())) {
      if(s1.charAt(i) == s2.charAt(j)) i++;
      j++;
    }
    return i == s1.length();
  }
}

