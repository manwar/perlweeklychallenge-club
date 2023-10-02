import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.stream.Collectors;
import java.util.HashMap;
import java.util.List;

public class Ch1 {
  public static boolean isExactChangePossible(int[] bills) {
    // we keep the bills in a "till"
    HashMap<Integer, Integer> till =
      new HashMap<Integer, Integer>();

    for (int collected : bills) {
      // put the bill we collected in the "till"
      //
      // using .getOrDefault(collected, 0) yields the value
      // in the map for the key 'collected' if it exists, or
      // the specified default (in this case, 0) if it doesn't
      till.put(
        collected,
        till.getOrDefault(collected, 0) + 1
      );

      // calculate the required change
      int change_required = collected - 5;

      // loop through the bills we have on hand, making sure
      // we go from largest to smallest bill
      List<Integer> keys = new ArrayList<>(till.keySet());
      Collections.sort(keys, Collections.reverseOrder());
      for (Integer bill : keys) {
        // as long as we have more of this bill and
        // using it would not yield TOO MUCH change
        while (till.get(bill) > 0 &&
               change_required - bill >= 0) {
          // deduct the amount from the required change
          change_required -= bill;

          // remove the bill from the till
          till.put(bill, till.get(bill) - 1);
        }
      }
      // if we weren't able to make change, fail
      if (change_required > 0) {
          return false;
      }
    }
    return true;
  }

  public static String joined(int[] ints) {
    // we're using it more than once, make it a method
    return Arrays.stream(ints)
                 .mapToObj(String::valueOf)
                 .collect(Collectors.joining(", "));
  }

  public static void solution(int[] bills) {
    System.out.println("Input: @bills = (" + joined(bills) + ")");
    boolean output = isExactChangePossible(bills);
    System.out.println("Output: " + output);
  }

  public static void main(String[] args) {
    System.out.println("Example 1:");
    solution(new int[] {5, 5, 5, 10, 20});

    System.out.println("\nExample 2:");
    solution(new int[] {5, 5, 10, 10, 20});

    System.out.println("\nExample 3:");
    solution(new int[] {5, 5, 5, 20});
  }
}
