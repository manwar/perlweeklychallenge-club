import java.util.Arrays;
import java.util.Comparator;

public class Ch2 {
  public static void main(String[] args) {
    String[] arr1 = new String[]{"perl", "python", "raku"};
    String[] arr2 = new String[]{"the", "weekly", "challenge"};
    char[] c1 =
      new char[]{'h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k',
        'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z'};
    char[] c2 =
      new char[]{'c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h',
        'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z'};
    alien_dictionary(arr1, c1);
    alien_dictionary(arr2, c2);
    System.out.println(Arrays.toString(arr1));
    System.out.println(Arrays.toString(arr2));
  }

  private static void alien_dictionary(String[] words, char[] alien_chars) {
    String alienstr = String.valueOf(alien_chars);
    Arrays.sort(words, new Comparator<String>() {
      @Override
      public int compare(String o1, String o2) {
        return translate(o1, alienstr).compareTo(translate(o2, alienstr));
      }
    });
  }

  private static String translate(String str, String alien) {
    char[] ret = new char[str.length()];
    for (int i = 0; i < str.length(); ++i)
      ret[i] = alien.charAt(str.charAt(i) - 'a');
    return String.valueOf(ret);
  }
}
