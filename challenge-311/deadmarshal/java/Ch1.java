public class Ch1 {
  public static void main(String[] args) {
    System.out.println(upper_lower("pERl"));
    System.out.println(upper_lower("rakU"));
    System.out.println(upper_lower("PyThOn"));
  }

  private static String upper_lower(String str) {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < str.length(); ++i) {
      char c = str.charAt(i);
      if (Character.isUpperCase(c)) sb.append(Character.toLowerCase(c));
      else sb.append(Character.toUpperCase(c));
    }
    return sb.toString();
  }
}
