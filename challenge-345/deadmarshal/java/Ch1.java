import java.util.List;
import java.util.ArrayList;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(peak_positions(new int[]{1,3,2}));
    System.out.println(peak_positions(new int[]{2,4,6,5,3}));
    System.out.println(peak_positions(new int[]{1,2,3,2,4,1}));
    System.out.println(peak_positions(new int[]{5,3,1}));
    System.out.println(peak_positions(new int[]{1,5,1,5,1,5,1}));
  }

  private static List<Integer> peak_positions(int[] arr) {
    List<Integer> res = new ArrayList<>();
    for(int i = 1; i < arr.length-1; ++i) {
      if(arr[i-1] < arr[i] && arr[i+1] < arr[i]) res.add(i);
    }
    return res;
  }
}

