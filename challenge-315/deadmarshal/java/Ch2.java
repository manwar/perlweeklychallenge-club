import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(find_third("Perl is a my favourite language but Python" +
      " is my favourite too.", "my", "favourite"));
    System.out.println(find_third("Barbie is a beautiful doll also also a " +
      "beautiful princess.", "a", "beautiful"));
    System.out.println(find_third("we will we will rock you rock you.", "we", "will"));
  }

  private static List<String> find_third(String sentence,
                                         String first,
                                         String second) {
    List<String> ret = new ArrayList<>();
    String[] words = sentence.split(" ");
    for (int i = 0; i < words.length - 1; ++i)
      if ((Objects.equals(words[i], first)) && (Objects.equals(words[i + 1], second)))
        ret.add(words[i + 2].replaceAll("[^a-zA-Z]", ""));
    return ret;
  }
}

