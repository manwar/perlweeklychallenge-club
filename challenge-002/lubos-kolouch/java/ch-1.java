/**
 * Perl Weekly Challenge 002 - Task 1.
 * Remove leading zeros from a positive number represented as a string.
 */
class Challenge002Task1 {
    static String removeLeadingZeros(String num) {
        int i = 0;
        while (i < num.length() - 1 && num.charAt(i) == '0') {
            i++;
        }
        return num.substring(i);
    }

    private static void runTests() {
        if (!"1234".equals(removeLeadingZeros("0001234"))) {
            throw new AssertionError("Expected 1234");
        }
        if (!"0".equals(removeLeadingZeros("000"))) {
            throw new AssertionError("Expected 0");
        }
        if (!"0".equals(removeLeadingZeros("0"))) {
            throw new AssertionError("Expected 0");
        }
        System.out.println("ok - challenge 002 task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length != 1) {
            throw new IllegalArgumentException("Usage: java Challenge002Task1 <number>");
        }

        System.out.println(removeLeadingZeros(args[0]));
    }
}
