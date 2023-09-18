import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;

public class Ch2 {
  public static ArrayList<int[]> findTriplets(int[] ints) {
    ArrayList<int[]> solutions = new ArrayList<int[]>();
    for (int i = 0; i < ints.length - 2; i++) {
      for (int j = i + 1; j < ints.length - 1; j++) {
        for (int k = j + 1; k < ints.length; k++) {
          if (ints[i] != ints[j] &&
              ints[j] != ints[k] &&
              ints[i] != ints[k]) {
            int triplet[] = {i, j, k};
            solutions.add( triplet );
          }
        }
      }
    }
    return solutions;
  }

  public static void solution(int[] ints) {
    String joined = Arrays.stream(ints)
                           .mapToObj(String::valueOf)
                           .collect(Collectors.joining(", "));
    System.out.println("Input: @ints = (" + joined + ")");
    ArrayList<int[]> solutions = findTriplets(ints);
    System.out.println(String.format("Output: %1$d", solutions.size()));
    for (int[] solution : solutions) {
      System.out.println(String.format(
        "(%1$d, %2$d, %3$d) because %4$d != %5$d != %6$d",
        solution[0],  solution[1],  solution[2],
        ints[solution[0]],  ints[solution[1]],  ints[solution[2]]
      ));
    }
  }
  public static void main(String[] args) {
    System.out.println("Example 1:");
    solution(new int[] {4, 4, 2, 4, 3});

    System.out.println("\nExample 2:");
    solution(new int[] {1, 1, 1, 1, 1});

    System.out.println("\nExample 3:");
    solution(new int[] {4, 7, 1, 10, 7, 4, 1, 1});
  }
}