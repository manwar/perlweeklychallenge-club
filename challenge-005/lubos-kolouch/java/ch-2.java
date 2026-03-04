import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * Perl Weekly Challenge 005 - Task 2.
 * Find the sequence of characters that has the most anagrams.
 */
class Challenge005Task2 {
    private static List<String> findAnagrams(String text) {
        Set<String> unique = new LinkedHashSet<String>();
        permute(text.toCharArray(), 0, unique);
        return new ArrayList<String>(unique);
    }

    private static void permute(char[] chars, int index, Set<String> out) {
        if (index == chars.length) {
            out.add(new String(chars));
            return;
        }

        for (int i = index; i < chars.length; i++) {
            swap(chars, index, i);
            permute(chars, index + 1, out);
            swap(chars, index, i);
        }
    }

    private static void swap(char[] chars, int i, int j) {
        char tmp = chars[i];
        chars[i] = chars[j];
        chars[j] = tmp;
    }

    private static String mostAnagrams(String text) {
        int maxCount = -1;
        String best = "";

        for (int i = 1; i <= text.length(); i++) {
            String candidate = text.substring(0, i);
            int count = findAnagrams(candidate).size();
            if (count > maxCount) {
                maxCount = count;
                best = candidate;
            }
        }

        return best;
    }

    private static void runTests() {
        List<String> gotAnagrams = findAnagrams("cat");
        Set<String> gotSet = new LinkedHashSet<String>(gotAnagrams);
        Set<String> expectedSet = new LinkedHashSet<String>(Arrays.asList("cat", "cta", "act", "atc", "tca", "tac"));
        if (!gotSet.equals(expectedSet)) {
            throw new AssertionError("Unexpected findAnagrams output: " + gotAnagrams);
        }

        String gotMost = mostAnagrams("cat");
        if (!"cat".equals(gotMost)) {
            throw new AssertionError("Expected cat, got " + gotMost);
        }

        System.out.println("ok - challenge 005 task 2 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length != 1) {
            throw new IllegalArgumentException("Usage: java Challenge005Task2 <string>");
        }

        System.out.println(mostAnagrams(args[0]));
    }
}
