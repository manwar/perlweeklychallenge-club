public class Ch1 {
  public static void main(String[] args) {
    System.out.println(arrange_binary(new int[]{1, 0, 0, 0, 1}, 1));
    System.out.println(arrange_binary(new int[]{1, 0, 0, 0, 1}, 2));
  }

  private static boolean arrange_binary(int[] nums, int n) {
    int c = 0;
    for (int i = 0; i < nums.length - 1; ++i)
      if (nums[i] == 0 && nums[i + 1] == 0) c++;
    return c > n;
  }
}

