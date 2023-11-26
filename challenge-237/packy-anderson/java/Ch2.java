import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

public class Ch2 {
  public static String joined(int[] ints) {
    // we're using it more than once, make it a method
    return Arrays.stream(ints)
                 .mapToObj(String::valueOf)
                 .collect(Collectors.joining(", "));
  }

  public static int greatness(int[] nums, int[] perm) {
    // determine the "greatness" of a permutation
    // relative to the original array; accepts two
    // arrays to do the comparison
    int greatness_num = 0;
    for (int i = 0; i < nums.length; i++) {
      if (nums[i] < perm[i]) {
        greatness_num++;
      }
    }
    return greatness_num;
  }

  public static int[] greatestPermutation(int[] nums) {
    // first, count up how many of each num we have
    HashMap<Integer, Integer> num_count =
      new HashMap<Integer, Integer>();
    for (int i = 0; i < nums.length; i++) {
      num_count.put(
        nums[i],
        num_count.getOrDefault(nums[i], 0) + 1
      );
    }

    // make a list of the available numbers
    // to put in a permutation
    List<Integer> available =
      new ArrayList<>(num_count.keySet());
    Collections.sort(available);

    // now, build a permutation that maximizes "greatness"
    List<Integer> perm = new ArrayList<>();
    for (Integer num : nums) {
      // default to the smallest available number
      int num_to_add = available.get(0);
      for (int i = 0; i < available.size(); i++) {
        int this_num = available.get(i);
        if (num < this_num) {
          num_to_add = this_num;
          break;
        }
      }
      perm.add(num_to_add);

      // decrement the count of that number available
      num_count.put(
        num_to_add,
        num_count.get(num_to_add) - 1
      );
  
      // if there are no more of that number, remove it
      // from available list
      if ( num_count.get(num_to_add) == 0 ) {
        // filter array to not include $num
        int size = available.size();
        for (int i = 1; i < size; i++) {
          int this_num = available.get(i);
          if (num_to_add == this_num) {
            available.remove(i);
            break;
          }
        }
      }
    }

    // because we built the permutations in a List,
    // convert the list to an int array for return
    int[] perm_return = new int[perm.size()];
    for (int i = 0; i < perm.size(); i++) {
      perm_return[i] = perm.get(i);
    }
    return perm_return;
  }

  public static void solution(int[] nums) {
    System.out.println(String.format(
      "Input: @nums = (%s)", joined(nums)
    ));
    int[] greatest = greatestPermutation(nums);
    int greatness_num = greatness(nums, greatest);
    System.out.println(String.format(
      "Output: %d", greatness_num
    ));
    System.out.println(String.format(
      "\nOne possible permutation: (%s)", joined(greatest)
    ));
    System.out.println(String.format(
      "which returns %d greatness as below:", greatness_num
    ));
    for (int i = 0; i < nums.length; i++) {
      if (nums[i] < greatest[i]) {
        System.out.println(String.format(
          "nums[%d] < perm[%d]", i, i
        ));
      }
    }
  }

  public static void main(String[] args) {
    System.out.println("Example 1:");
    solution(new int[] {1, 3, 5, 2, 1, 3, 1});

    System.out.println("\nExample 2:");
    solution(new int[] {1, 2, 3, 4});
  }
}
