public class Ch2 {
  public static void main(String[] args) {
    System.out.println(reverse_letters("p-er?l"));
    System.out.println(reverse_letters("wee-k!L-y"));
    System.out.println(reverse_letters("_c-!h_all-en!g_e"));
  }

  private static String reverse_letters(String str) {
    char[] chars = str.toCharArray();
    int i = 0, j = str.length() - 1;
    while (i < j) {
      while (i < j && !Character.isLetter(chars[i])) ++i;
      while (i < j && !Character.isLetter(chars[j])) --j;
      if (i < j) {
        char temp = chars[i];
        chars[i] = chars[j];
        chars[j] = temp;
        ++i;
        --j;
      }
    }
    return new String(chars);
  }
}