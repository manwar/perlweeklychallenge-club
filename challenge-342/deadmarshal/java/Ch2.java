public class Ch2 {
  public static void main(String[] args) {
    System.out.println(max_score("0011"));
    System.out.println(max_score("0000"));
    System.out.println(max_score("1111"));
    System.out.println(max_score("0101"));
    System.out.println(max_score("011101"));
  }

  private static int max_score(String str) {
    int res = 0;
    for(int i = 1; i < str.length(); ++i) {
      int temp = 0;
      for(int j = 0; j < i; ++j)
	if(str.charAt(j) == '0') ++temp;
      for(int j = i; j < str.length(); ++j)
	if(str.charAt(j) == '1') ++temp;
      res = Math.max(res,temp);
    }
    return res;
  }
}

