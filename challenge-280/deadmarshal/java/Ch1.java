public class Ch1 {
  public static void main(String[] args) {
    System.out.println(twice_appearance("acbddbca"));
    System.out.println(twice_appearance("abccd"));
    System.out.println(twice_appearance("abcdabbb"));
  }

  private static char twice_appearance(String str) {
    int[] counts = new int[26];
    for (int i = 0; i < str.length(); ++i) {
      int idx = str.charAt(i) - 'a';
      if (counts[idx] != 0) return str.charAt(i);
      counts[idx]++;
    }
    return '\0';
  }
}
