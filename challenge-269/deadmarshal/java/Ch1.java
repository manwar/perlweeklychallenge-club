import java.util.ArrayList;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    List<Integer> list1 = new ArrayList<>(List.of(1, 2, 3, 4, 5));
    List<Integer> list2 = new ArrayList<>(List.of(2, 3, 8, 16));
    List<Integer> list3 = new ArrayList<>(List.of(1, 2, 5, 7, 9));
    System.out.println(bitwise_or(list1));
    System.out.println(bitwise_or(list2));
    System.out.println(bitwise_or(list3));
  }

  private static boolean bitwise_or(List<Integer> list) {
    return (list.stream().filter(e -> (e % 2) == 0).count() > 1);
  }
}

