import java.util.ArrayList;
import java.util.List;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(binaryReflection(new int[]{3,6,12}));
    System.out.println(binaryReflection(new int[]{1,2,4,8}));
    System.out.println(binaryReflection(new int[]{7,8,9,10}));
    System.out.println(binaryReflection(new int[]{5,9,15,17}));
    System.out.println(binaryReflection(new int[]{11,13,14,19}));
  }

  private static long reflect(long u) {
    return Long.reverse(u) >>> Long.numberOfLeadingZeros(u);
  }

  public static int cmp(int a, int b) {
    int c = Long.compareUnsigned(reflect(a),reflect(b));
    return c != 0 ? c : Integer.compare(a,b);
  }
  
  private static List<Integer> binaryReflection(int[] xs) {
    List<Integer> out = new ArrayList<>(xs.length);
    for(int x : xs) out.add(x);
    out.sort(Ch2::cmp);
    return out;
  } 
}

