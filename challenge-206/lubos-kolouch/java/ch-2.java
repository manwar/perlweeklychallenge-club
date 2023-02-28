import java.util.Arrays;

public class MaxMinPairSum {
  public static int maxMinPairSum(int[] array) {
    // Sort the array in ascending order
    Arrays.sort(array);

    // Use pairwise iteration to get pairs of adjacent elements
    // (0,1), (2,3), (4,5), ...
    int sum = 0;
    for (int i = 0; i < array.length; i += 2) {
      sum += Math.min(array[i], array[i + 1]);
    }

    return sum;
  }

  public static void main(String[] args) {
    // Define test cases
    int[] test1 = {1, 2, 3, 4};
    int expected1 = 4;
    int[] test2 = {0, 2, 1, 3};
    int expected2 = 2;

    // Run tests
    assert (maxMinPairSum(test1) == expected1);
    assert (maxMinPairSum(test2) == expected2);
  }
}
