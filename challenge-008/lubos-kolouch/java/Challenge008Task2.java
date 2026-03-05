import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Perl Weekly Challenge 008 - Task 2.
 * Write a function called center that takes a list of strings and returns the strings modified with leading spaces.
 */
public class Challenge008Task2 {

    public static List<String> center(List<String> lines) {
        int maxLength = 0;
        for (String line : lines) {
            maxLength = Math.max(maxLength, line.length());
        }

        List<String> centeredLines = new ArrayList<>();
        for (String line : lines) {
            int padding = (maxLength - line.length()) / 2;
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < padding; i++) {
                sb.append(" ");
            }
            sb.append(line);
            centeredLines.add(sb.toString());
        }
        return centeredLines;
    }

    private static void runTests() {
        List<String> input = Arrays.asList("This", "is", "a test of the", "center function");
        List<String> got = center(input);

        // Longest is "center function" (15 chars)
        // "This" (4 chars) -> (15-4)/2 = 5 spaces -> "     This"
        // "is" (2 chars) -> (15-2)/2 = 6 spaces -> "      is"
        // "a test of the" (13 chars) -> (15-13)/2 = 1 space -> " a test of the"
        // "center function" (15 chars) -> (15-15)/2 = 0 spaces -> "center function"

        List<String> expected = Arrays.asList(
            "     This",
            "      is",
            " a test of the",
            "center function"
        );

        if (!got.equals(expected)) {
            throw new AssertionError("Test failed. Expected: \n" + expected + "\nGot: \n" + got);
        }
        System.out.println("ok - Challenge 008 Task 2 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        List<String> lines;
        if (args.length == 0) {
            lines = Arrays.asList("This", "is", "a test of the", "center function");
        } else {
            lines = Arrays.asList(args);
        }

        for (String line : center(lines)) {
            System.out.println(line);
        }
    }
}
