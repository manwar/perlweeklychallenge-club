import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(
      find_anagrams(new String[]{"acca", "dog", "god", "perl", "repl"}));
    System.out.println(
      find_anagrams(new String[]{"abba", "baba", "aabb", "ab", "ab"}));
  }

  private static int find_anagrams(String[] arr) {
    int sum = 1;
    for (int i = 0; i < arr.length; ++i) {
      arr[i] = Stream.of(arr[i].split(""))
        .sorted()
        .collect(Collectors.joining());
    }
    for (int i = 1; i < arr.length; ++i)
      if (!Objects.equals(arr[i - 1], arr[i])) sum++;
    return sum;
  }
}
