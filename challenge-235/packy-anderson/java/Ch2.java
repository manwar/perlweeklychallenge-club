import java.util.Arrays;
import java.util.stream.Collectors;

public class Ch2 {
  public static String joined(int[] ints) {
    // we're using it more than once, make it a method
    return Arrays.stream(ints)
                 .mapToObj(String::valueOf)
                 .collect(Collectors.joining(", "));
  }

  public static int[] duplicateZeros(int[] ints) {
    for (int i = 0; i < ints.length; i++) {
      if (ints[i] == 0) {
        // shift all the values in the array to the right by one 
        for (int j = ints.length - 1; j > i; j--) {
          ints[j] = ints[j - 1];
        }
        ints[i + 1] = 0; // insert a new 0
        i++; // skip over the 0 we added!
      }
    }
    return ints;
  }

  public static void solution(int[] ints) {
    System.out.println("Input: @ints = (" + joined(ints) + ")");
    ints = duplicateZeros(ints);
    System.out.println("Output: (" + joined(ints) + ")");
  }

  public static void main(String[] args) {
    System.out.println("Example 1:");
    solution(new int[] {1, 0, 2, 3, 0, 4, 5, 0});

    System.out.println("\nExample 2:");
    solution(new int[] {1, 2, 3});

    System.out.println("\nExample 3:");
    solution(new int[] {0, 3, 0, 4, 5});
  }
}
