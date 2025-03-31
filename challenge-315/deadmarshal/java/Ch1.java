import java.util.ArrayList;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(find_words(new String[]{"the", "weekly", "challenge"},
      'e'));
    System.out.println(find_words(new String[]{"perl", "raku", "python"}, 'p'));
    System.out.println(find_words(new String[]{"abc", "def", "bbb", "bcd"}, 'b'));
  }

  private static List<Integer> find_words(String[] arr, char p) {
    List<Integer> ret = new ArrayList<>();
    for (int i = 0; i < arr.length; ++i)
      if (arr[i].indexOf(p) != -1) ret.add(i);
    return ret;
  }
}

