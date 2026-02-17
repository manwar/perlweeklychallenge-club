import java.util.List;
import java.util.ArrayList;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(zeckendorf_representation(4));
    System.out.println(zeckendorf_representation(12));
    System.out.println(zeckendorf_representation(20));
    System.out.println(zeckendorf_representation(96));
    System.out.println(zeckendorf_representation(100));
  }

  private static List<Integer> zeckendorf_representation(int n) {
    List<Integer> fibs = new ArrayList<>();
    fibs.add(1);
    fibs.add(2);
    while(fibs.get(fibs.size()-1) + fibs.get(fibs.size()-2) <= n) {
      fibs.add(fibs.get(fibs.size()-1) + fibs.get(fibs.size()-2));
    }
    int i = fibs.size()-1,rem = n;
    List<Integer> parts = new ArrayList<>();
    while(rem != 0) {
      if(fibs.get(i) <= rem) {
	parts.add(fibs.get(i));
	rem -= fibs.get(i);
	i -= 2;
      } else i--;
    }
    return parts;
  }
}

