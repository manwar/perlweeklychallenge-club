import java.util.ArrayList;
import java.util.List;
import java.util.HashSet;
import java.util.Arrays;
import java.util.Set;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(
      match_string(new String[]{"cat","cats","dog","dogcat",
				"dogcat","rat","ratcatdogcat"}));
    System.out.println(
      match_string(new String[]{"hello","hell","world",
				"wor","ellow","elloworld"}));
    System.out.println(match_string(new String[]{"a","aa","aaa","aaaa"}));
    System.out.println(
      match_string(new String[]{"flower", "flow", "flight",
				"fl", "fli", "ig", "ght"}));
    System.out.println(
      match_string(new String[]{"car","carpet","carpenter","pet",
				"enter","pen","pent"}));
  }

  private static List<String> match_string(String[] strs) {
    Set<String> res = new HashSet<>();
    for(int i = 0; i < strs.length; ++i) {
      final String a = strs[i];
      final int indexA = i;
      boolean isContained = Arrays.stream(strs)
	.anyMatch(b -> indexA != Arrays.asList(strs).indexOf(b)
		  && b.contains(a));
      if(isContained) res.add(a);
    }
    return new ArrayList<>(res);
  }
}

