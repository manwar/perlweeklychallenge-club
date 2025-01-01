public class Ch2 {
  public static void main(String[] args) {
    System.out.println(step_by_step(new int[]{-3, 2, -3, 4, 2}));
    System.out.println(step_by_step(new int[]{1, 2}));
    System.out.println(step_by_step(new int[]{1, -2, -3}));
  }

  private static int step_by_step(int[] arr) {
    int s = 0;
    int t = Integer.MAX_VALUE;
    for (int n : arr) {
      s += n;
      t = Math.min(t, s);
    }
    return Math.max(1, 1 - t);
  }
}
