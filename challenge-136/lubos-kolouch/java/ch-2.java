import java.util.*;

public class Main {
  static List<Integer> fib = Arrays.asList(1, 2, 3, 5, 8, 13, 21, 34, 55, 89);

  static int countFibSequences(int n, int i, List<Integer> fib) {
    if (n < 0) {
      return 0;
    }
    if (n == 0) {
      return 1;
    }
    if (i == fib.size()) {
      return 0;
    }
    return countFibSequences(n - fib.get(i), i + 1, fib) +
        countFibSequences(n, i + 1, fib);
  }

  public static void main(String[] args) {
    System.out.println(countFibSequences(16, 0, fib));
    System.out.println(countFibSequences(9, 0, fib));
    System.out.println(countFibSequences(15, 0, fib));
  }
}
