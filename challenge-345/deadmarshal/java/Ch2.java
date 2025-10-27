import java.util.List;
import java.util.LinkedList;
import java.util.ArrayList;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(last_visitor(new int[]{5,-1,-1}));
    System.out.println(last_visitor(new int[]{3,7,-1,-1,-1}));
    System.out.println(last_visitor(new int[]{2,-1,4,-1,-1}));
    System.out.println(last_visitor(new int[]{10,20,-1,30,-1,-1}));
    System.out.println(last_visitor(new int[]{-1,-1,5,-1}));
  }
  
  private static List<Integer> last_visitor(int[] arr) {
    List<Integer> res = new LinkedList<Integer>();
    List<Integer> seen = new ArrayList<Integer>();
    int k = 0;
    for(int i =0; i < arr.length; ++i) {
      if(arr[i] != -1) {
	seen.add(arr[i]);
	k = seen.size();
      }
      else if(k == 0) res.add(-1);
      else res.add(seen.get(--k));
    }
    return res;
  }
}
