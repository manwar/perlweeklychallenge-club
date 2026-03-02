
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Perl Weekly Challenge 001 - Task 2.
 *
 * Return classic FizzBuzz values for numbers 1..20.
 */
class Challenge001Task2 {
    static List<String> fizzBuzz() {
        List<String> output = new ArrayList<>();

        for (int i = 1; i <= 20; i++) {
            String line = "";
            if (i % 3 == 0) {
                line = "fizz";
            }
            if (i % 5 == 0) {
                line += "buzz";
            }
            if (line.isEmpty()) {
                line = Integer.toString(i);
            }
            output.add(line);
        }

        return output;
    }

    private static void runTests() {
        List<String> expected = Arrays.asList(
            "1", "2", "fizz", "4", "buzz", "fizz", "7", "8", "fizz", "buzz",
            "11", "fizz", "13", "14", "fizzbuzz", "16", "17", "fizz", "19", "buzz"
        );

        List<String> got = fizzBuzz();
        if (!expected.equals(got)) {
            throw new AssertionError("FizzBuzz output mismatch: " + got);
        }

        System.out.println("ok - task 2 example test passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        for (String line : fizzBuzz()) {
            System.out.println(line);
        }
    }
}
