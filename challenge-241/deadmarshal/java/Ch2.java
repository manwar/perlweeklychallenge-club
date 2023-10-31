import java.util.ArrayList;
import java.util.List;
import java.util.Comparator;

public class Ch2 {
  public static void main(String[] args) {
    ArrayList<Integer> list = new ArrayList<>(List.of(11,8,27,4));
    prime_order(list);
    System.out.println(list);
  }

  private static int count_factors(int n) {
    int c = 2,count = 0;
    while(n > 1) {
      if(n % c == 0) {
	n /= c;
	count++;
      }
      else c++;
    }
    return count;
  }

  private static void prime_order(List<Integer> list) {
    list.sort(new Comparator<Integer>() {
      @Override
      public int compare(Integer a, Integer b) {
      	int fa = count_factors(a);
      	int fb = count_factors(b);
      	return fa == fb ? Integer.compare(a,b) :
	  Integer.compare(fa,fb);
      }});
  }
}

