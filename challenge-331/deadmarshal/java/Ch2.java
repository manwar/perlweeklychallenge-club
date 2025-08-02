public class Ch2 {
  public static void main(String[] args) {
    System.out.println(buddy_strings("fuck", "fcuk"));
    System.out.println(buddy_strings("love", "love"));
    System.out.println(buddy_strings("fodo", "food"));
    System.out.println(buddy_strings("feed", "feed"));
  }

  private static boolean buddy_strings(String s1, String s2) {
    if (s1.length() != s2.length()) return false;
    int diff = 0;
    int[] count1 = new int[26];
    int[] count2 = new int[26];
    for (int i = 0; i < s1.length(); ++i) {
      int a = s1.charAt(i), b = s2.charAt(i);
      ++count1[a - 'a'];
      ++count2[b - 'a'];
      if (a != b) ++diff;
    }
    boolean f = false;
    for (int i = 0; i < 26; ++i) {
      if (count1[i] != count2[i]) return false;
      if (count1[i] > 1) f = true;
    }
    return diff == 2 || (diff == 0 && f);
  }
}
