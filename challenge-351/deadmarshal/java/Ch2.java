import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(arithmetic_progression(new double[]{1,3,5,7,9}));
    System.out.println(arithmetic_progression(new double[]{9,1,7,5,3}));
    System.out.println(arithmetic_progression(new double[]{1,2,4,8,16}));
    System.out.println(arithmetic_progression(new double[]{5,-1,3,1,-3}));
    System.out.println(arithmetic_progression(new double[]{1.5,3,0,4.5,6}));
  }

  private static boolean arithmetic_progression(double[] arr) {
    Arrays.sort(arr);
    double d = arr[1] - arr[0];
    for(int i = 2; i < arr.length; ++i) {
      if(arr[i] - arr[i-1] != d) return false;
    }
    return true;
  }
}

