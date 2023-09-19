import java.util.Arrays;
import java.util.stream.Collectors;

public class Ch1 {
  public static boolean isStrictlyIncreasingExceptOne(int[] ints) {
    // the list cannot be strictly increasing unless
    // there are at least two items in it
    if (ints.length <= 1) {
      return false;
    }

    int count = 0; // track how many exceptions

    // get the first integer from the list
    int last_int = ints[0];

    // note that we start with element 1, because
    // we've already put the value of the 0th
    // element into last_int
    for (int i = 1; i < ints.length; i++) {
      if (ints[i] <= last_int) {
        if (++count > 1) {
          // if we have encountered more than one
          // case where the current int is less than
          // or equal to the last int, we can bail
          // out early, because the check fails
          return false;
        }
      }

      // move the current int to the last int
      last_int = ints[i];
    }

    // if the count of cases where the list
    // wasn't increasing is equal to one,
    // then we return true, otherwise false
    return count == 1;
  }


  public static void solution(int[] ints) {
    String joined = Arrays.stream(ints)
                          .mapToObj(String::valueOf)
                          .collect(Collectors.joining(", "));
    System.out.println("Input: @ints = (" + joined + ")");
    boolean output = isStrictlyIncreasingExceptOne(ints);
    System.out.println("Output: " + output);
  }

  public static void main(String[] args) {
    System.out.println("Example 1:");
    solution(new int[] {0, 2, 9, 4, 6});

    System.out.println("\nExample 2:");
    solution(new int[] {5, 1, 3, 2});

    System.out.println("\nExample 3:");
    solution(new int[] {2, 2, 3});
  }
}