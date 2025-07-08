import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(counter_integers("the1weekly2challenge2"));
    System.out.println(counter_integers("go21od1lu5c7k"));
    System.out.println(counter_integers("4p3e2r1l"));
  }

  private static List<String> counter_integers(String word) {
    Set<String> s = new HashSet<>();
    int n = word.length();
    for (int i = 0; i < n; ++i) {
      if (Character.isDigit(word.charAt(i))) {
        while ((i < n) && (word.charAt(i) == '0')) ++i;
        int j = i;
        while ((j < n) && (Character.isDigit(word.charAt(j)))) ++j;
        s.add(word.substring(i, j));
        i = j;
      }
    }
    return s.stream().toList();
  }
}

