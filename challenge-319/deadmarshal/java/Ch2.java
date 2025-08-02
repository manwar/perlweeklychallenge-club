import java.util.Arrays;
import java.util.Collections;
import java.util.Set;
import java.util.stream.Collectors;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(minimum_common(new int[]{1, 2, 3, 4}, new int[]{3, 4, 5, 6}));
    System.out.println(minimum_common(new int[]{1, 2, 3}, new int[]{2, 4}));
    System.out.println(minimum_common(new int[]{1, 2, 3, 4}, new int[]{5, 6, 7, 8}));
  }

  private static int minimum_common(int[] arr1, int[] arr2) {
    Set<Integer> s1 = Arrays.stream(arr1).boxed().collect(Collectors.toSet()),
      s2 = Arrays.stream(arr2).boxed().collect(Collectors.toSet());
    s1.retainAll(s2);
    return s1.isEmpty() ? -1 : Collections.min(s1);
  }
}