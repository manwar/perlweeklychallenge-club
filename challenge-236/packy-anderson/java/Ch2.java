import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.stream.Collectors;

public class Ch2 {
  public static ArrayList<Integer> loopExistsAt(
    int start, int[] ints, HashMap<Integer, Integer> seen
  ) {
    // bail early if we're in a loop we've seen before
    if (seen.get(start) != null) {
      // return an empty ArrayList
      return new ArrayList<Integer>();
    }

    // initialize an empty list to start
    ArrayList<Integer> loop = new ArrayList<Integer>();
    // initialize i to starting point
    int i = start;
    while (true) {
      // keep track of the values in the order we visit them
      loop.add(ints[i]);

      // track where we've already been
      // to avoid double-counting loops
      seen.put(i, 1);

      // get the next index
      i = ints[i];

      // make sure the index is in bounds
      if (i < 0 || i >= ints.length) {
        break;
      }

      // make sure we haven't seen the index before
      if (seen.get(i) != null) {
        break;
      }
    }

    // if the last element points back to
    // the start, it's a loop!
    if (loop.get(loop.size() - 1) == start) {
        return loop;
    }

    // otherwise, return an empty ArrayList
    return new ArrayList<Integer>();
  }

  public static ArrayList<ArrayList<Integer>> identifyLoops(int[] ints) {
    ArrayList<ArrayList<Integer>> loops =
      new ArrayList<ArrayList<Integer>>();
    HashMap<Integer, Integer> seen =
      new HashMap<Integer, Integer>();

    for (int i = 0; i < ints.length; i++) {
      ArrayList<Integer> loop = loopExistsAt(i, ints, seen);
      if (loop.size() > 0) {
        loops.add(loop);
      }
    }
    return loops;
  }

  public static String comma_joined(int[] ints) {
    // we're using it more than once, make it a method
    return Arrays.stream(ints)
                 .mapToObj(String::valueOf)
                 .collect(Collectors.joining(","));
  }

  public static void solution(int[] ints) {
    System.out.println("Input: @ints = (" + comma_joined(ints) +
                       ")");
    ArrayList<ArrayList<Integer>> loops = identifyLoops(ints);
    int count = loops.size();
    System.out.println(String.format("Output: %1$d", count));
    if (count > 0) {
      String loop_noun = (count == 1) ? "Loop" : "Loops";
      String are_verb  = (count == 1) ? "is"   : "are";
      System.out.println("\n" + loop_noun + " " + are_verb +
                         " as below:");

      for (ArrayList<Integer> loop : loops) {
        String as_list = loop.stream()
                             .map(String::valueOf)
                             .collect(Collectors.joining(" "));
        System.out.println("[" + as_list + "]");
      }
    }
  }

  public static void main(String[] args) {
    System.out.println("Example 1:");
    solution(new int[] {4,6,3,8,15,0,13,18,7,16,14,
                        19,17,5,11,1,12,2,9,10});

    System.out.println("\nExample 2:");
    solution(new int[] {0,1,13,7,6,8,10,11,2,14,16,
                        4,12,9,17,5,3,18,15,19});

    System.out.println("\nExample 3:");
    solution(new int[] {9,8,3,11,5,7,13,19,12,4,14,
                        10,18,2,16,1,0,15,6,17});
  }
}
