import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(common_characters(new String[]{"bella", "label", "roller"}));
    System.out.println(common_characters(new String[]{"cool", "lock", "cook"}));
    System.out.println(common_characters(new String[]{"hello", "world", "pole"}));
    System.out.println(common_characters(new String[]{"abc", "def", "ghi"}));
    System.out.println(common_characters(new String[]{"aab", "aac", "aaa"}));
  }

  private static List<String> common_characters(String[] words) {
    int[] cnt = new int[26];
    Arrays.fill(cnt, Integer.MAX_VALUE);
    for (String w : words) {
      int[] ccnt = new int[26];
      for (int i = 0; i < w.length(); ++i) ++ccnt[w.charAt(i) - 'a'];
      for (int i = 0; i < 26; ++i) cnt[i] = Math.min(cnt[i], ccnt[i]);
    }
    List<String> res = new ArrayList<>();
    for (int i = 0; i < 26; ++i)
      while (cnt[i]-- > 0) res.add(String.valueOf((char) (i + 'a')));
    return res;
  }
}

