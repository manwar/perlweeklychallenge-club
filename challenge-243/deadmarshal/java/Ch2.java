import java.util.ArrayList;
import java.util.List;

public class Ch2 {
  public static void main(String[] args) {
    ArrayList<Integer> list1 = new ArrayList<>(List.of(2,5,9));
    ArrayList<Integer> list2 = new ArrayList<>(List.of(7,7,7,7,7,7,7));
    System.out.println(floor_sum(list1));
    System.out.println(floor_sum(list2));
  }
  
  private static int floor_sum(List<Integer> list) {
    int sum = 0;
    for(int i = 0; i < list.size(); ++i)
      for(int j = 0; j < list.size(); ++j)
	sum += list.get(i) / list.get(j);
    return sum;
  }
}

