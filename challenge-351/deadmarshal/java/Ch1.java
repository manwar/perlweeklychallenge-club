import java.util.Arrays;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(
      special_average(new int[]{8000,5000,6000,2000,3000,7000}));
    System.out.println(
      special_average(new int[]{100_000,80_000,110_000,90_000}));
    System.out.println(
      special_average(new int[]{2500,2500,2500,2500}));
    System.out.println(special_average(new int[]{2000}));
    System.out.println(
      special_average(new int[]{1000,2000,3000,4000,5000,6000}));
  }

  private static int special_average(int[] arr) {
    if(arr.length < 2) return 0;
    Arrays.sort(arr);
    int[] sub = Arrays.copyOfRange(arr,1,arr.length-1);
    int sum = 0;
    for(int n : sub) sum += n;
    return sum / sub.length;
  }
}

