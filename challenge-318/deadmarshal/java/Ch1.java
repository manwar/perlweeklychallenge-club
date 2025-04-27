import java.util.ArrayList;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(group_position("abccccd"));
    System.out.println(group_position("aaabcddddeefff"));
    System.out.println(group_position("abcdd"));
  }

  private static List<String> group_position(String str) {
    List<String> groups = new ArrayList<>();
    int i = 0, j;
    int n = str.length()
    while (i < n) {
      j = i;
      while ((j < n) && (str.charAt(j) == str.charAt(i))) j++;
      if (j - i >= 3) groups.add(str.substring(i, j - 1));
      i = j;
    }
    return groups;
  }
}

