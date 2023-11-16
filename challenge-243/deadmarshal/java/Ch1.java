import java.util.ArrayList;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    ArrayList<Integer> list1 = new ArrayList<>(List.of(1,3,2,3,1));
    ArrayList<Integer> list2 = new ArrayList<>(List.of(2,4,3,5,1));
    System.out.println(reverse_pairs(list1));
    System.out.println(reverse_pairs(list2));
  }

  private static int reverse_pairs(List<Integer> list) {
    int count = 0;
    for(int i = 0; i < list.size()-1; ++i)
      for(int j = i+1; j < list.size(); ++j)
	if(list.get(i) > 2 * list.get(j)) count++;
    return count;
  }
}

