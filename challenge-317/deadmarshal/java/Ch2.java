import java.util.Set;
import java.util.stream.Collectors;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(friendly_strings("desc", "dsec"));
    System.out.println(friendly_strings("fuck", "fcuk"));
    System.out.println(friendly_strings("poo", "eop"));
    System.out.println(friendly_strings("stripe", "sprite"));
  }

  private static boolean friendly_strings(String s1, String s2) {
    Set<Character> set1 = s1.chars().mapToObj(c -> (char) c).collect(Collectors.toSet());
    Set<Character> set2 =
      s2.chars().mapToObj(c -> (char) c).collect(Collectors.toSet());
    return set1.equals(set2);
  }
}
