import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class Ch2 {
  public static void main(String[] args) {
    ArrayList<Integer> list1 = new ArrayList<>(List.of(15,99,1,34));
    ArrayList<Integer> list2 = new ArrayList<>(List.of(50,25,33,22));
    persistence_sort(list1);
    persistence_sort(list2);
    System.out.println(list1);
    System.out.println(list2);
  }

  private static int product(int n) {
    int prod = 1;
    while(n > 0)
    {
      prod *= n % 10;
      n /= 10;
    }
    return prod;
  }

  private static int helper(int n) {
    int sum = 0;
    while(n >= 10)
    {
      sum++;
      n = product(n);
    }
    return sum;
  }
  
  private static void persistence_sort(List<Integer> list) {
    list.sort(new Comparator<Integer>() {
      @Override
      public int compare(Integer a, Integer b) {
      	int ha = helper(a);
      	int hb = helper(b);
      	return ha == hb ? Integer.compare(a,b) : 
	  Integer.compare(ha,hb);
      }});
  }
}

