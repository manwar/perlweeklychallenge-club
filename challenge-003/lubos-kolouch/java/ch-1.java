import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Perl Weekly Challenge 003 - Task 1.
 * Generate 5-smooth numbers (prime factors only 2, 3, 5).
 */
class Challenge003Task1 {
    static boolean isSmooth(int n) {
        int value = n;
        while (value % 2 == 0) {
            value /= 2;
        }
        while (value % 3 == 0) {
            value /= 3;
        }
        while (value % 5 == 0) {
            value /= 5;
        }
        return value == 1;
    }

    static List<Integer> generateSmoothNumbers(int count) {
        List<Integer> smooth = new ArrayList<>();
        smooth.add(1);
        int candidate = 1;
        while (smooth.size() < count) {
            candidate++;
            if (isSmooth(candidate)) {
                smooth.add(candidate);
            }
        }
        return smooth;
    }

    private static void runTests() {
        List<Integer> expected = Arrays.asList(1, 2, 3, 4, 5, 6, 8, 9, 10, 12);
        List<Integer> got = generateSmoothNumbers(10);
        if (!expected.equals(got)) {
            throw new AssertionError("Expected " + expected + " got " + got);
        }
        System.out.println("ok - challenge 003 task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        int count = args.length == 0 ? 10 : Integer.parseInt(args[0]);
        List<Integer> smooth = generateSmoothNumbers(count);
        System.out.println("First " + count + " 5-smooth numbers:");
        for (int i = 0; i < smooth.size(); i++) {
            if (i > 0) {
                System.out.print(", ");
            }
            System.out.print(smooth.get(i));
        }
        System.out.println();
    }
}
