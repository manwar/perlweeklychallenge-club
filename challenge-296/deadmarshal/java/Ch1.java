public class Ch1 {
  public static void main(String[] args) {
    System.out.println(string_compression("abbc"));
    System.out.println(string_compression("aaabccc"));
    System.out.println(string_compression("abcc"));
    System.out.println("-".repeat(50));
    System.out.println(decompress(string_compression("abbc")));
    System.out.println(decompress(string_compression("aaabccc")));
    System.out.println(decompress(string_compression("abcc")));
  }

  private static String string_compression(String str) {
    StringBuilder sb = new StringBuilder();
    int count = 1;
    char[] chars = str.toCharArray();
    for (int i = 0; i < chars.length; ++i) {
      while (i + 1 < chars.length && chars[i] == chars[i + 1]) {
        count++;
        i++;
      }
      if (count == 1) sb.append(chars[i]);
      else sb.append(count).append(chars[i]);
      count = 1;
    }
    return sb.toString();
  }

  private static String decompress(String str) {
    StringBuilder sb = new StringBuilder();
    char[] chars = str.toCharArray();
    for (int i = 0; i < chars.length; ++i) {
      if (Character.isAlphabetic(chars[i])) {
        sb.append(chars[i]);
      } else {
        int d = Character.getNumericValue(chars[i++]);
        sb.append(String.valueOf(chars[i]).repeat(d));
      }
    }
    return sb.toString();
  }
}
