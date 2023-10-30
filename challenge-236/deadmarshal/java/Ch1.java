import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    ArrayList<Integer> arr1 = new ArrayList<>(List.of(5,5,5,10,20));
    ArrayList<Integer> arr2 = new ArrayList<>(List.of(5,5,10,10,20));
    ArrayList<Integer> arr3 = new ArrayList<>(List.of(5,5,5,20));
    System.out.println(exact_change(arr1));
    System.out.println(exact_change(arr2));
    System.out.println(exact_change(arr3));
  }

  private static boolean exact_change(List<Integer> list) {
    HashMap<Integer,Integer> m = new HashMap<Integer,Integer>();
    for(var e : list)
    {
      if(e == 10)
      {
        m.replace(5, m.get(5) - 1);
        if(m.get(5) == 0) return false;
      }
      else if(e == 20)
      {
        if(m.getOrDefault(5,0) != 0 &&
          m.getOrDefault(10,0) != 0)
        {
          m.replace(5,m.get(5)-1);
          m.replace(10,m.get(10)-1);
        }
        else if(m.get(5) > 2) m.replace(5,m.get(5)-3);
        else return false;
      }
      m.put(e,m.getOrDefault(e,0)+1);
    }
    return true;
  }
}
