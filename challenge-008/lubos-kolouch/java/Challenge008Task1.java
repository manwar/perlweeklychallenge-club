import java.util.ArrayList;
import java.util.List;

/**
 * Perl Weekly Challenge 008 - Task 1.
 * Write a script that computes the first five perfect numbers.
 * A perfect number is a positive integer that is equal to the sum of its positive proper divisors.
 */
public class Challenge008Task1 {

    public static boolean isPrime(long n) {
        if (n < 2) return false;
        if (n == 2) return true;
        if (n % 2 == 0) return false;
        for (long i = 3; i * i <= n; i += 2) {
            if (n % i == 0) return false;
        }
        return true;
    }

    public static List<Long> getFirstNPerfectNumbers(int n) {
        List<Long> perfectNumbers = new ArrayList<>();
        int p = 2;
        while (perfectNumbers.size() < n) {
            // Using Euclid-Euler theorem: 2^(p-1) * (2^p - 1) is a perfect number
            // if 2^p - 1 is a Mersenne prime.
            long mersenneCandidate = (1L << p) - 1;
            if (isPrime(mersenneCandidate)) {
                long perfectNumber = (1L << (p - 1)) * mersenneCandidate;
                perfectNumbers.add(perfectNumber);
            }
            p++;
        }
        return perfectNumbers;
    }

    private static void runTests() {
        List<Long> got = getFirstNPerfectNumbers(4);
        long[] expected = {6, 28, 496, 8128};
        if (got.size() != expected.length) {
            throw new AssertionError("Test failed. Expected size " + expected.length + ", got " + got.size());
        }
        for (int i = 0; i < expected.length; i++) {
            if (got.get(i) != expected[i]) {
                throw new AssertionError("Test failed at index " + i + ". Expected " + expected[i] + ", got " + got.get(i));
            }
        }
        System.out.println("ok - Challenge 008 Task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        List<Long> perfectNumbers = getFirstNPerfectNumbers(5);
        System.out.println("The first five perfect numbers are: " + perfectNumbers);
    }
}
