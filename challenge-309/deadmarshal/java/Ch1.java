public class Ch1 {
  public static void main(String[] args) {
    System.out.println(min_gap(new int[]{2, 8, 10, 11, 15}));
    System.out.println(min_gap(new int[]{1, 5, 6, 7, 14}));
    System.out.println(min_gap(new int[]{8, 20, 25, 28}));
  }

  private static int min_gap(int[] arr) {
    assert arr.length >= 2;
    int min = arr[0];
    int min_gap = arr[1] - arr[0];
    for (int i = 2; i < arr.length; ++i) {
      int gap = arr[i] - arr[i - 1];
      if (gap < min_gap) {
        min = arr[i];
        min_gap = gap;
      }
    }
    return min;
  }
}
