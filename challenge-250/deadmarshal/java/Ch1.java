import java.util.ArrayList;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    ArrayList<Integer> list1 = new ArrayList<>(List.of(0,1,2));
    ArrayList<Integer> list2 = new ArrayList<>(List.of(4,3,2,1));
    ArrayList<Integer> list3 = new ArrayList<>(List.of(1,2,3,4,5,6,7,8,9,0));
    System.out.println(smallest_index(list1));
    System.out.println(smallest_index(list2));
    System.out.println(smallest_index(list3));
  }
	
  private static int smallest_index(List<Integer> list) {
    for(int i = 0; i < list.size(); ++i) if(i % 10 == list.get(i)) return i;
    return -1;
  }
}

