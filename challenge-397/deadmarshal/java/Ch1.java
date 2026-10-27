import java.util.HashSet;
import java.util.Set;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(absentSmallestPositive(new int[]{1, 2, 4, 5, 6}));
    System.out.println(absentSmallestPositive(new int[]{-5, -2, -1, 3}));
    System.out.println(absentSmallestPositive(new int[]{1, 2, 3}));
    System.out.println(absentSmallestPositive(new int[]{2, 3, 7, 8}));
    System.out.println(absentSmallestPositive(new int[]{1, 1, 1, 10}));
  }

  private static int absentSmallestPositive(int[] arr) {
    int sum = 0;
    Set<Integer> h = new HashSet<>();
    for(int e : arr) {
      h.add(e);
      sum += e;
    }
    int ret = Math.max(1,sum / arr.length + 1);
    while(h.contains(ret)) ret++;
    return ret;
  }
}

