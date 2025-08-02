import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Ch1 {
  public static void main(String[] args) {
    List<List<Integer>> l1 = List.of(List.of(1, 2, 3, 4), List.of(4, 5, 6, 1),
      List.of(4, 2, 1, 3));
    List<List<Integer>> l2 = List.of(List.of(1, 0, 2, 3), List.of(2, 4, 5));
    List<List<Integer>> l3 =
      List.of(List.of(1, 2, 3), List.of(4, 5), List.of(6));
    System.out.println(arrays_intersection(l1));
    System.out.println(arrays_intersection(l2));
    System.out.println(arrays_intersection(l3));
  }

  private static <T> List<T> arrays_intersection(List<List<T>> lists) {
    Set<T> ret = new HashSet<>(lists.getFirst());
    for (List<T> l : lists) ret.retainAll(new HashSet<>(l));
    return new ArrayList<>(ret);
  }
}
