import java.util.HashMap;
import java.util.Map;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(odd_letters("weekly"));
    System.out.println(odd_letters("perl"));
    System.out.println(odd_letters("challenge"));
  }

  private static boolean odd_letters(String s) {
    Map<Character, Integer> h = new HashMap<>();
    for (var c : s.toCharArray()) h.merge(c, 1, Integer::sum);
    return h.values().stream().allMatch(a -> a % 2 != 0);
  }
}
