import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    int[] arr1 = new int[]{0,2,1,5,3,4};
    int[] arr2 = new int[]{5,0,1,2,3,4};
    System.out.println(Arrays.toString(build_array(arr1)));
    System.out.println(Arrays.toString(build_array(arr2)));
  }

  private static int[] build_array(int[] arr) {
    int[] ret = new int[arr.length];
    for(int i = 0; i < arr.length; ++i) ret[i] = arr[arr[i]];
    return ret;
  }
}

