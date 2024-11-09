import java.util.Arrays;
import java.util.Collections;

public class Ch2 {
  public static void main(String[] args) {
    int[] arr1 = new int[]{1, 2, 3};
    int[] arr2 = new int[]{2, 1, 3};
    int[] arr3 = new int[]{3, 1, 2};
    next_permutation(arr1);
    next_permutation(arr2);
    next_permutation(arr3);
    System.out.println(Arrays.toString(arr1));
    System.out.println(Arrays.toString(arr2));
    System.out.println(Arrays.toString(arr3));
  }

  private static void next_permutation(int[] arr) {
    int p = -1;
    for (int i = arr.length - 2; i >= 0; --i)
      if (arr[i] < arr[i + 1]) {
        p = i;
        break;
      }
    if (p == -1) Collections.reverse(Arrays.asList(arr));
    for (int i = arr.length - 1; i >= p; --i)
      if (arr[i] > arr[p]) {
        int t = arr[i];
        arr[i] = arr[p];
        arr[p] = t;
        break;
      }
    Collections.reverse(Arrays.asList(Arrays.copyOfRange(arr, p + 1,
      arr.length - 1)));
  }
}

