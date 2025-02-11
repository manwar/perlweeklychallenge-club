public class Ch2 {
  public static void main(String[] args) {
    System.out.println(maximum_average(new int[]{1, 12, -5, -6, 50, 3}, 4));
    System.out.println(maximum_average(new int[]{5}, 1));
  }

  private static double maximum_average(int[] nums, int n) {
    double max = 0, avg;
    for (int start = 0; start <= nums.length - n; ++start) {
      double subsum = 0;
      for (int i = start; i < start + n; ++i) subsum += nums[i];
      avg = subsum / n;
      if (avg > max) max = avg;
    }
    return max;
  }
}
