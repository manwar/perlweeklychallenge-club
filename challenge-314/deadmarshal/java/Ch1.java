public class Ch1 {
  public static void main(String[] args) {
    System.out.println(equal_strings("abc", "abb", "ab"));
    System.out.println(equal_strings("ayz", "cyz", "xyz"));
    System.out.println(equal_strings("yza", "yzb", "yzc"));
  }

  private static int equal_strings(String s1, String s2, String s3) {
    int sum = s1.length() + s2.length() + s3.length();
    int n = Math.min(Math.min(s1.length(), s2.length()), s3.length());
    for (int i = 0; i < n; ++i) {
      if (!(s1.charAt(i) == s2.charAt(i) && s2.charAt(i) == s3.charAt(i)))
        return i == 0 ? -1 : sum - 3 * i;
    }
    return sum - 3 * n;
  }
}