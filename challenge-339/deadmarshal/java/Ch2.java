import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(peak_point(new int[] { -5, 1, 5, -9, 2 }));
    System.out.println(peak_point(new int[] { 10, 10, 10, -25 }));
    System.out.println(peak_point(new int[] { 3, -4, 2, 5, -6, 1 }));
    System.out.println(peak_point(new int[] { -1, -2, -3, -4 }));
    System.out.println(peak_point(new int[] { -10, 15, 5 }));
  }

  private static int peak_point(int[] arr) {
    List<Integer> l = new ArrayList<>();
    l.add(0);
    for (var e : arr)
      l.add(l.getLast() + e);
    return Collections.max(l);
  }
}
