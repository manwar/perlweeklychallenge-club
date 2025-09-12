import java.util.Arrays;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(Arrays.toString(smaller_than_current(new int[]{6, 5, 4, 8})));
    System.out.println(Arrays.toString(smaller_than_current(new int[]{7, 7, 7, 7})));
    System.out.println(Arrays.toString(smaller_than_current(new int[]{5, 4, 3
      , 2, 1})));
    System.out.println(Arrays.toString(smaller_than_current(new int[]{-1, 0, 3, -2, 1})));
    System.out.println(Arrays.toString(smaller_than_current(new int[]{0, 1, 1, 2, 0})));
  }

  private static int[] smaller_than_current(int[] nums) {
    int[] arr = nums.clone();
    Arrays.sort(arr);
    for (int i = 0; i < nums.length; ++i) nums[i] = search(arr, nums[i]);
    return nums;
  }

  private static int search(int[] nums, int x) {
    int l = 0, r = nums.length;
    while (l < r) {
      int mid = (l + r) / 2;
      if (nums[mid] >= x) r = mid;
      else l = mid + 1;
    }
    return l;
  }
}
