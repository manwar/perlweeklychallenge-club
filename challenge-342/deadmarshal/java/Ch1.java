public class Ch1 {
  public static void main(String[] args) {
    System.out.println(balance_string("a0b1c2"));
    System.out.println(balance_string("abc12"));
    System.out.println(balance_string("0a2b1c3"));
    System.out.println(balance_string("1a23"));
    System.out.println(balance_string("ab123"));
  }

  private static String balance_string(String str) {
    StringBuilder a = new StringBuilder();
    StringBuilder b = new StringBuilder();
    for(char c : str.toCharArray()) {
      if(Character.isDigit(c)) a.append(c);
      else b.append(c);
    }
    int m = a.length(), n = b.length();
    if(Math.abs(m-n) > 1) return "";
    StringBuilder res = new StringBuilder();
    for(int i = 0; i < Math.min(m,n); ++i) {
      if(m > n) {
	res.append(a.charAt(i)).append(b.charAt(i));
      } else {
	res.append(b.charAt(i)).append(a.charAt(i));
      }
    }
    if(m > n) res.append(a.charAt(m-1));
    if(m < n) res.append(b.charAt(n-1));
    return res.toString();
  }
}

