public class Ch1 {
  public static void main(String[] args) {
    System.out.println(range_sum(new int[]{-2, 0, 3, -5, 2, -1}, 0, 2));
    System.out.println(range_sum(new int[]{1, -2, 3, -4, 5}, 1, 3));
    System.out.println(range_sum(new int[]{1, 0, 2, -1, 3}, 3, 4));
    System.out.println(range_sum(new int[]{-5, 4, -3, 2, -1, 0}, 0, 3));
    System.out.println(range_sum(new int[]{-1, 0, 2, -3, -2, 1}, 0, 2));
  }

  private static int range_sum(int[] arr, int x, int y) {
    int s = 0;
    for (int i = x; i <= y; i++) s += arr[i];
    return s;
  }
}