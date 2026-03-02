/**
 * Perl Weekly Challenge 002 - Task 2.
 * Convert integers to and from base35 using digits 0-9 and A-Y.
 */
class Challenge002Task2 {
    private static final String DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXY";

    static int base35ToInt(String value) {
        int result = 0;
        String upper = value.toUpperCase();
        for (int i = 0; i < upper.length(); i++) {
            int d = DIGITS.indexOf(upper.charAt(i));
            if (d < 0) {
                throw new IllegalArgumentException("Invalid base35 digit: " + upper.charAt(i));
            }
            result = result * 35 + d;
        }
        return result;
    }

    static String intToBase35(int value) {
        if (value < 0) {
            throw new IllegalArgumentException("Negative numbers are not supported");
        }
        if (value == 0) {
            return "0";
        }

        StringBuilder out = new StringBuilder();
        int n = value;
        while (n > 0) {
            out.append(DIGITS.charAt(n % 35));
            n /= 35;
        }
        return out.reverse().toString();
    }

    private static void runTests() {
        if (base35ToInt("A") != 10) {
            throw new AssertionError("Expected 10");
        }
        if (base35ToInt("1A") != 45) {
            throw new AssertionError("Expected 45");
        }
        if (!"1A".equals(intToBase35(45))) {
            throw new AssertionError("Expected 1A");
        }
        if (!"A2P".equals(intToBase35(12345))) {
            throw new AssertionError("Expected A2P");
        }
        System.out.println("ok - challenge 002 task 2 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length != 2 || !("to".equals(args[0]) || "from".equals(args[0]))) {
            throw new IllegalArgumentException("Usage: java Challenge002Task2 <to|from> <value>");
        }

        if ("to".equals(args[0])) {
            int value = Integer.parseInt(args[1]);
            System.out.println(intToBase35(value));
        } else {
            System.out.println(base35ToInt(args[1]));
        }
    }
}
