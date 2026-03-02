
/**
 * Perl Weekly Challenge 001 - Task 1.
 *
 * Replace all lowercase 'e' with 'E' and return the number of replacements.
 */
class Challenge001Task1 {
    static final class ReplaceResult {
        final int count;
        final String replaced;

        ReplaceResult(int count, String replaced) {
            this.count = count;
            this.replaced = replaced;
        }
    }

    static ReplaceResult replaceE(String input) {
        int count = 0;
        StringBuilder out = new StringBuilder(input.length());

        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (c == 'e') {
                out.append('E');
                count++;
            } else {
                out.append(c);
            }
        }

        return new ReplaceResult(count, out.toString());
    }

    private static void runTests() {
        ReplaceResult result = replaceE("Perl Weekly Challenge");
        if (result.count != 5) {
            throw new AssertionError("Expected count 5, got " + result.count);
        }
        if (!"PErl WEEkly ChallEngE".equals(result.replaced)) {
            throw new AssertionError("Unexpected replacement output: " + result.replaced);
        }
        System.out.println("ok - task 1 example test passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        ReplaceResult result = replaceE("Perl Weekly Challenge");
        System.out.println(result.count);
        System.out.println(result.replaced);
    }
}
