import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Ch2 {
  public static void main(String[] args) {
    ArrayList<Integer> arr1 = new ArrayList<>(
      List.of(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10));
    ArrayList<Integer> arr2 = new ArrayList<>(
      List.of(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19));
    ArrayList<Integer> arr3 = new ArrayList<>(
      List.of(9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17));
    System.out.println(array_loops(arr1));
    System.out.println(array_loops(arr2));
    System.out.println(array_loops(arr3));
  }

  private static int array_loops(List<Integer> list) {
    int count = 0, i = 0;
    List<Integer> indices =
      new ArrayList<Integer>(Collections.nCopies(list.size(), -1));
    for(; i < list.size(); ++i)
    {
      if(indices.get(i) == -1)
      {
        count++;
        while(indices.get(i) == -1)
        {
          indices.set(i,1);
          i = list.get(i);
        }
      }
    }
    return count;
  }
}
