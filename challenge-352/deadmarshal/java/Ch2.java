import java.util.List;
import java.util.ArrayList;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(binary_prefix(new int[]{0,1,1,0,0,1,0,1,1,1}));
    System.out.println(binary_prefix(new int[]{1,0,1,0,1,0}));
    System.out.println(binary_prefix(new int[]{0,0,1,0,1}));
    System.out.println(binary_prefix(new int[]{1,1,1,1,1}));
    System.out.println(binary_prefix(new int[]{1,0,1,1,0,1,0,0,1,1}));
  }

  private static List<Boolean> binary_prefix(int[] arr) {
    List<Boolean> res = new ArrayList<>();
    int x = 0;
    for(int e : arr) {
      x = (x << 1 | e) % 5;
      res.add(x == 0);
    }
    return res;
  }
}

