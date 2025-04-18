import java.util.Arrays;
import java.util.stream.Collectors;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(acronyms(new String[]{"Perl", "Weekly", "Challenge"}, "PWC"));
    System.out.println(acronyms(new String[]{"Bob", "Charlie", "Joe"}, "BCJ"));
    System.out.println(acronyms(new String[]{"Morning", "Good"}, "MM"));
  }

  private static boolean acronyms(String[] arr, String str) {
    String concatenated = Arrays.stream(arr)
      .filter(s -> s != null && !s.isEmpty())
      .map(s -> s.substring(0, 1))
      .collect(Collectors.joining());
    return concatenated.equals(str);
  }
}