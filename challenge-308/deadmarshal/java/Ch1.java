import java.util.Arrays;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(count_common(new String[]{"perl", "weekly", "challenge"},
      new String[]{"raku", "weekly", "challenge"}));
    System.out.println(count_common(new String[]{"perl", "raku", "python"},
      new String[]{"python", "java"}));
    System.out.println(count_common(new String[]{"guest", "contribution"},
      new String[]{"fun", "weekly", "challenge"}));
  }

  private static int count_common(String[] strs1, String[] strs2) {
    return (int) Arrays.stream(strs1)
      .distinct()
      .filter(x -> Arrays.stream(strs2).anyMatch(y -> y == x))
      .count();
  }
}
