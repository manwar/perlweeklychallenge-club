import java.util.Arrays;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(word_count(new String[]{"unicode", "xml", "raku", "perl"}));
    System.out.println(word_count(new String[]{"the", "weekly", "challenge"}));
    System.out.println(word_count(new String[]{"perl", "python", "postgres"}));
  }

  private static int word_count(String[] arr) {
    return (int) Arrays.stream(arr)
      .filter(s -> !s.isEmpty() &&
        s.toLowerCase().matches("^[aeiou].*|.*[aeiou]$"))
      .count();
  }
}
