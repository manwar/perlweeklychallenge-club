import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Perl Weekly Challenge 006 - Task 1.
 * Create a compact range of numbers from a given list of integers.
 */
public class Challenge006Task1 {

    /**
     * Compacts a list of integers into a string of ranges.
     *
     * @param numbers The list of integers.
     * @return The compact range string.
     */
    public static String compactList(int[] numbers) {
        if (numbers == null || numbers.length == 0) {
            return "";
        }

        Arrays.sort(numbers);

        List<String> compactList = new ArrayList<>();
        int start = numbers[0];
        int last = numbers[0];

        for (int i = 1; i < numbers.length; i++) {
            if (numbers[i] == last + 1) {
                last = numbers[i];
            } else {
                if (start == last) {
                    compactList.add(String.valueOf(start));
                } else {
                    compactList.add(start + "-" + last);
                }
                start = numbers[i];
                last = numbers[i];
            }
        }

        if (start == last) {
            compactList.add(String.valueOf(start));
        } else {
            compactList.add(start + "-" + last);
        }

        return String.join(",", compactList);
    }

    private static void runTests() {
        int[] input = {1, 2, 3, 4, 9, 10, 14, 15, 16};
        String got = compactList(input);
        String expected = "1-4,9-10,14-16"; // Note: the Perl/Python solution joins 9,10 as 9-10.
        // Let's re-verify the Perl/Python logic.

        if (!got.equals(expected)) {
            // Re-check: Python/Perl logic for 9,10.
            // Python:
            // if numbers[i] - numbers[i - 1] == 1: end = numbers[i]
            // else: if start == end: compact_list.append(str(start)) else: compact_list.append(str(start) + "-" + str(end))
            // So for 9,10: i-1 is 9, i is 10. 10-9 == 1. end becomes 10.
            // Then it hits the 'else' or loop end.
            // If next is 14: start=9, end=10. start != end, so "9-10".
            // The prompt says "9,10" in the example but the code produces "9-10".
            // User's Perl code: if ($num == $last_num + 1) { $last_num = $num; } else { ... if ($first_num == $last_num) { push @compact_list, $first_num; } else { push @compact_list, "$first_num-$last_num"; } ... }
            // So 9,10 will indeed be 9-10 in the user's current logic.
            // I will stick to the user's implementation logic.
            throw new AssertionError("Test failed. Expected " + expected + ", got " + got);
        }

        System.out.println("ok - Challenge 006 Task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length == 0) {
            System.err.println("Usage: java Challenge006Task1 <n1,n2,n3...>");
            System.exit(1);
        }

        String[] parts = args[0].split(",");
        int[] numbers = new int[parts.length];
        for (int i = 0; i < parts.length; i++) {
            numbers[i] = Integer.parseInt(parts[i].trim());
        }

        System.out.println(compactList(numbers));
    }
}
