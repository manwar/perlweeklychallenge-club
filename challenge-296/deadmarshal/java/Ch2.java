import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Ch2 {
  public static void main(String[] args) {
    ArrayList<Integer> arr1 = new ArrayList<>(List.of(1, 2, 2, 2, 1));
    ArrayList<Integer> arr2 = new ArrayList<>(List.of(2, 2, 2, 4));
    ArrayList<Integer> arr3 = new ArrayList<>(List.of(2, 2, 2, 2, 4));
    ArrayList<Integer> arr4 = new ArrayList<>(List.of(3, 4, 1, 4, 3, 1));
    System.out.println(matchstick_square(arr1));
    System.out.println(matchstick_square(arr2));
    System.out.println(matchstick_square(arr3));
    System.out.println(matchstick_square(arr4));
  }

  private static boolean matchstick_square(List<Integer> list) {
    int sum = list.stream().mapToInt(Integer::intValue).sum();
    if (sum % 4 != 0) return false;
    int len = sum / 4;
    list.sort(Collections.reverseOrder());
    ArrayList<Integer> sides = new ArrayList<>(List.of(0, 0, 0, 0));
    return dfs(list, sides, len, 0);
  }

  private static boolean dfs(List<Integer> list, List<Integer> sides,
			     int len,
                             int i) {
    if (i == list.size()) {
      return sides.parallelStream().allMatch(t -> t == len);
    }
    for (int j = 0; j < sides.size(); ++j) {
      if (sides.get(j) + list.get(i) <= len) {
        sides.set(j, sides.get(j) + list.get(i));
        if (dfs(list, sides, len, i + 1)) return true;
        sides.set(j, sides.get(j) - list.get(i));
      }
    }
    return false;
  }
}

