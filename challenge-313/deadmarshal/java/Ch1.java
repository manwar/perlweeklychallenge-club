import java.util.Set;
import java.util.stream.Collectors;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(broken_keys("perl", "perrrl"));
    System.out.println(broken_keys("raku", "rrakuuuu"));
    System.out.println(broken_keys("python", "perl"));
    System.out.println(broken_keys("coffeescript", "cofffeescccript"));
  }

  private static boolean broken_keys(String name, String typed) {
    Set<Character> s1 =
      name.chars().mapToObj(e -> (char) e).collect(Collectors.toSet());
    Set<Character> s2 =
      typed.chars().mapToObj(e -> (char) e).collect(Collectors.toSet());
    return s1.containsAll(s2);
  }
}