import java.util.ArrayList;
import java.util.List;

public class Ch2 {
  public static void main(String[] args) {
    List<Integer> list1 = new ArrayList<>(List.of(2, 1, 3, 4, 5));
    List<Integer> list2 = new ArrayList<>(List.of(3, 2, 4));
    List<Integer> list3 = new ArrayList<>(List.of(5, 4, 3, 8));
    try {
      System.out.println(distribute_elements(list1));
      System.out.println(distribute_elements(list2));
      System.out.println(distribute_elements(list3));
    } catch (NotEnoughElements e) {
      System.err.println(e.getMessage());
    }
  }

  private static List<Integer> distribute_elements(List<Integer> list)
    throws NotEnoughElements {
    if (list.size() < 2) throw new NotEnoughElements();
    List<Integer> ret1 = new ArrayList<>(List.of(list.removeFirst()));
    List<Integer> ret2 = new ArrayList<>(List.of(list.removeFirst()));
    while (!list.isEmpty()) {
      int e = list.removeFirst();
      if (ret1.getLast() > ret2.getLast()) ret1.add(e);
      else ret2.add(e);
    }
    ret1.addAll(ret2);
    return ret1;
  }

  private static class NotEnoughElements extends Exception {
  }
}

