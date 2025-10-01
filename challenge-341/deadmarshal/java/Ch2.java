public class Ch2 {
  public static void main(String[] args) {
    System.out.println(reversePrefix("programming",'g'));
    System.out.println(reversePrefix("hello",'h'));
    System.out.println(reversePrefix("abcdefghij",'h'));
    System.out.println(reversePrefix("reverse",'s'));
    System.out.println(reversePrefix("perl",'r'));
  }

  private static String reversePrefix(String str,char c) {
    int idx = str.indexOf(c);
    if(idx == -1) return str;
    return new StringBuilder(str.substring(0,idx+1))
      .reverse()
      .toString() +
      str.substring(idx+1);
  }
}

