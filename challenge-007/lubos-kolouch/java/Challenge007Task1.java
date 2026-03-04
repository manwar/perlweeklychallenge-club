import java.util.ArrayList;
import java.util.List;

/**
 * Perl Weekly Challenge 007 - Task 1.
 * Print all Niven numbers (Harshad numbers) from 0 to 50.
 * A Niven number is an integer that is divisible by the sum of its digits.
 */
public class Challenge007Task1 {

    public static int sumOfDigits(int number) {
        int sum = 0;
        int n = Math.abs(number);
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return sum;
    }

    public static List<Integer> getNivenNumbers(int limit) {
        List<Integer> result = new ArrayList<>();
        for (int i = 1; i <= limit; i++) {
            int sum = sumOfDigits(i);
            if (sum > 0 && i % sum == 0) {
                result.add(i);
            }
        }
        return result;
    }

    private static void runTests() {
        List<Integer> got = getNivenNumbers(20);
        // Niven numbers up to 20: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 18, 20
        int[] expectedArr = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 18, 20};
        if (got.size() != expectedArr.length) {
            throw new AssertionError("Test failed. Expected size " + expectedArr.length + ", got " + got.size());
        }
        for (int i = 0; i < expectedArr.length; i++) {
            if (!got.get(i).equals(expectedArr[i])) {
                throw new AssertionError("Test failed at index " + i + ". Expected " + expectedArr[i] + ", got " + got.get(i));
            }
        }
        System.out.println("ok - Challenge 007 Task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        int limit = 50;
        if (args.length == 1) {
            limit = Integer.parseInt(args[0]);
        }

        for (int num : getNivenNumbers(limit)) {
            System.out.println(num);
        }
    }
}
