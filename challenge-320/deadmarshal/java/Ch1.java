public class Ch1 {
  public static void main(String[] args) {
    System.out.println(maximum_count(new int[]{-3, -2, -1, 1, 2, 3}));
    System.out.println(maximum_count(new int[]{-2, -1, 0, 0, 1}));
    System.out.println(maximum_count(new int[]{1, 2, 3, 4}));
  }

  private static int maximum_count(int[] arr) {
    int n = 0, p = 0;
    for (int num : arr) {
      if (num != 0) {
        if (num < 0) n++;
        else p++;
      }
    }
    return Math.max(n, p);
  }
}