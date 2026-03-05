import java.util.LinkedHashSet;
import java.util.Set;

/**
 * Perl Weekly Challenge 005 - Task 1.
 * Print all anagrams for a given word.
 * In this implementation, "anagrams" refers to all unique permutations of the string.
 */
public class Challenge005Task1 {

    /**
     * Generates all unique anagrams (permutations) of a word.
     *
     * @param word The word to generate anagrams for.
     * @return A set of all unique anagrams.
     */
    public static Set<String> getAnagrams(String word) {
        Set<String> anagrams = new LinkedHashSet<>();
        if (word == null || word.isEmpty()) {
            return anagrams;
        }
        permute("", word, anagrams);
        return anagrams;
    }

    private static void permute(String prefix, String remaining, Set<String> anagrams) {
        int n = remaining.length();
        if (n == 0) {
            anagrams.add(prefix);
        } else {
            for (int i = 0; i < n; i++) {
                permute(prefix + remaining.charAt(i),
                        remaining.substring(0, i) + remaining.substring(i + 1, n),
                        anagrams);
            }
        }
    }

    private static void runTests() {
        Set<String> got = getAnagrams("cat");
        Set<String> expected = new LinkedHashSet<>();
        expected.add("cat");
        expected.add("cta");
        expected.add("act");
        expected.add("atc");
        expected.add("tca");
        expected.add("tac");

        if (!got.equals(expected)) {
            throw new AssertionError("Test failed for 'cat'. Expected " + expected + ", got " + got);
        }

        got = getAnagrams("aa");
        expected = new LinkedHashSet<>();
        expected.add("aa");
        if (!got.equals(expected)) {
            throw new AssertionError("Test failed for 'aa'. Expected " + expected + ", got " + got);
        }

        System.out.println("ok - Challenge 005 Task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length != 1) {
            System.err.println("Usage: java Challenge005Task1 <word>");
            System.exit(1);
        }

        for (String anagram : getAnagrams(args[0])) {
            System.out.println(anagram);
        }
    }
}
