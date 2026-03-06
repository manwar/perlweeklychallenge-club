import java.util.HashSet;
import java.util.Set;

/**
 * Perl Weekly Challenge 009 - Task 1.
 * Write a script that finds the first square number that has at least 5 distinct digits.
 */
public class Challenge009Task1 {

    public static long findFirstSquareWithDistinctDigits(int distinctCount) {
        long num = 1;
        while (true) {
            long square = num * num;
            if (countDistinctDigits(square) >= distinctCount) {
                return square;
            }
            num++;
        }
    }

    private static int countDistinctDigits(long n) {
        String s = String.valueOf(n);
        Set<Character> distinct = new HashSet<>();
        for (char c : s.toCharArray()) {
            distinct.add(c);
        }
        return distinct.size();
    }

    private static void runTests() {
        long got = findFirstSquareWithDistinctDigits(5);
        // Let's check:
        // 113^2 = 12769 (5 distinct: 1, 2, 7, 6, 9)
        if (got != 12769) {
             throw new AssertionError("Test failed. Expected 12769, got " + got);
        }
        System.out.println("ok - Challenge 009 Task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        System.out.println(findFirstSquareWithDistinctDigits(5));
    }
}
