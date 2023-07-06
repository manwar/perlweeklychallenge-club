import java.util.HashMap;
import java.util.Map;

public class Main {
  public static void main(String[] args) {
    System.out.println(canFormTarget("abc", "xyz")); // Output: false
    System.out.println(
        canFormTarget("scriptinglanguage", "perl"));    // Output: true
    System.out.println(canFormTarget("aabbcc", "abc")); // Output: true
  }

  public static boolean canFormTarget(String source, String target) {
    Map<Character, Integer> sourceChars = new HashMap<>();
    for (char c : source.toCharArray()) {
      sourceChars.put(c, sourceChars.getOrDefault(c, 0) + 1);
    }

    for (char c : target.toCharArray()) {
      if (!sourceChars.containsKey(c) || sourceChars.get(c) == 0) {
        return false;
      }
      sourceChars.put(c, sourceChars.get(c) - 1);
    }
    return true;
  }
}
