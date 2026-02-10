import java.util.Arrays;
import java.util.stream.Collectors;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(wordSorter("The quick brown fox"));
    System.out.println(wordSorter("Hello    World!   How   are you?"));
    System.out.println(wordSorter("Hello"));
    System.out.println(wordSorter("Hello, World! How are you?"));
    System.out.println(wordSorter("I have 2 apples and 3 bananas!"));
  }

  private static String wordSorter(String str) {
    return Arrays.stream(str.trim().split("\\s+"))
      .sorted(String::compareToIgnoreCase)
      .collect(Collectors.joining(" "));
  }
}

