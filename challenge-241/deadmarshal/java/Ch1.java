import java.util.ArrayList;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    ArrayList<Integer> list1 =
      new ArrayList<>(List.of(0,1,4,6,7,10));
    ArrayList<Integer> list2 =
      new ArrayList<>(List.of(4,5,6,7,8,9));
    System.out.println(arithmetic_triplets(list1,3));
    System.out.println(arithmetic_triplets(list2,2));
  }

  private static int arithmetic_triplets(List<Integer> list,int diff){
    int count = 0;
    for(int i = 0; i < list.size(); ++i) {
      for(int j = i+1; j < list.size(); ++j) {
	for(int k = j+1; k < list.size(); ++k) {
	  if((list.get(j) - list.get(i) == diff) &&
	     (list.get(k) - list.get(j) == diff))
	    count++;
	}
      }
    }
    return count;
  }
}

