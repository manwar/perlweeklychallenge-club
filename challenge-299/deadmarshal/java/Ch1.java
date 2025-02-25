import java.util.HashMap;
import java.util.Map;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(replace_words(new String[]{"cat", "bat", "rat"},
      "the cattle was rattle by the battery"));
    System.out.println(replace_words(new String[]{"a", "b", "c"},
      "aab aac and cac bab"));
    System.out.println(replace_words(new String[]{"man", "bike"},
      "the manager was hit by a biker"));
  }

  private static String replace_words(String[] arr, String sentence) {
    String[] words = sentence.split("\\s");
    Map<String, Integer> roots = new HashMap<>();
    for (String s : arr) roots.put(s, 1);
    for (int i = 0; i < words.length; ++i) {
      for (int j = 1; j < words[i].length(); ++j) {
        String sub = words[i].substring(0, j);
        if (roots.containsKey(sub)) {
          words[i] = sub;
          break;
        }
      }
    }
    return String.join(" ", words);
  }
}

