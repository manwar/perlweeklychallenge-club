import java.util.Arrays;
import java.util.stream.Collectors;

public class Ch1 {
  public static String joined(int[] ints) {
    // we're using it more than once, make it a method
    return Arrays.stream(ints)
                 .mapToObj(String::valueOf)
                 .collect(Collectors.joining(", "));
  }

  public static boolean isStrictlyIncreasing(int[] ints) {
    // get the first integer from the list
    int last_int = ints[0];

    // note that we start with element 1, because
    // we've already put the value of the 0th
    // element into last_int
    for (int i = 1; i < ints.length; i++) {
      if (ints[i] <= last_int) {
        return false;
      }
      last_int = ints[i];
    }
    return true;
  }

  public static boolean isStrictlyIncreasingExceptOne(int[] ints) {
    // the list cannot be strictly increasing unless
    // there are at least two items in it
    if (ints.length <= 1) {
      return false;
    }

    // if it's strictly increasing without removing
    // an item, it fails the test
    if (isStrictlyIncreasing(ints)) {
      return false;
    }

    for (int i = 1; i < ints.length; i++) {
      if (ints[i] <= ints[i-1]) {
        // make a new list to hold the list
        // with one value removed
        int[] newlist = new int[ints.length - 1];
        // copy over all but the (i-1)th element
        for (int j = 0; j < ints.length; j++) {
          if (j == i - 1) {
            continue;
          }
          if (j < i - 1) {
            newlist[j] = ints[j];
          }
          else {
            newlist[j-1] = ints[j];
          }
        }
        // now test this new list to see
        // if it's strictly increasing
        return isStrictlyIncreasing(newlist);
      }
    }
    return false;
  }


  public static void solution(int[] ints) {
    System.out.println("Input: @ints = (" + joined(ints) + ")");
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

    System.out.println("\nExample 4 from James Curtis-Smith:");
    solution(new int[] {1,2,3,4,1,2,3});
  }
}