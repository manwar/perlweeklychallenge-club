import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * Perl Weekly Challenge 005 - Task 2.
 * Find the sequence of characters that has the most anagrams.
 * Following the logic of the user's Perl solution, this program finds the
 * sorted character sequence that appears most often as a substring's character set.
 */
public class Challenge005Task2 {

    /**
     * Finds the sequence of characters that has the most anagrammatic substrings.
     *
     * @param text The input string.
     * @return The character sequence with the most anagrammatic substrings.
     */
    public static String findMostAnagrams(String text) {
        if (text == null || text.isEmpty()) {
            return "";
        }

        Map<String, Integer> anagramCounts = new HashMap<>();
        int maxAnagrams = 0;
        String bestSequence = "";

        // Iterate over each substring
        for (int i = 0; i < text.length(); i++) {
            for (int j = i + 1; j <= text.length(); j++) {
                String substring = text.substring(i, j);

                // Sort the characters of the substring to create a key
                char[] chars = substring.toCharArray();
                Arrays.sort(chars);
                String sortedSubstring = new String(chars);

                // Add the substring to the anagrams count
                int count = anagramCounts.getOrDefault(sortedSubstring, 0) + 1;
                anagramCounts.put(sortedSubstring, count);

                // Update the maximum anagrams and the sequence
                if (count > maxAnagrams) {
                    maxAnagrams = count;
                    bestSequence = sortedSubstring;
                }
            }
        }

        return bestSequence;
    }

    private static void runTests() {
        // "abba"
        // Substrings: "a", "b", "b", "a", "ab", "bb", "ba", "abb", "bba", "abba"
        // sorted char sequences:
        // "a": 2
        // "b": 2
        // "ab": 2
        // "bb": 1
        // "abb": 2
        // "aabb": 1
        // Max count is 2. The first one it finds would be "a".
        String got = findMostAnagrams("abba");
        if (!"a".equals(got)) {
            // "a", "b", "ab", "abb" are all valid.
            // Depending on the order, we might get any of them.
            // Our implementation updates bestSequence when count > maxAnagrams.
            // So for "abba":
            // "a" (1) -> maxAnagrams=1, best="a"
            // "b" (1) -> count <= max, no update
            // "b" (2) -> count > max, maxAnagrams=2, best="b"
            // "a" (2) -> count <= max, no update
            // ...
            // Let's check what it actually returns.
            // i=0, j=1: substring="a", sorted="a", count=1, max=1, best="a"
            // i=1, j=2: substring="b", sorted="b", count=1
            // i=2, j=3: substring="b", sorted="b", count=2, max=2, best="b"
            // i=3, j=4: substring="a", sorted="a", count=2
            // i=0, j=2: substring="ab", sorted="ab", count=1
            // i=1, j=3: substring="bb", sorted="bb", count=1
            // i=2, j=4: substring="ba", sorted="ab", count=2
            // i=0, j=3: substring="abb", sorted="abb", count=1
            // i=1, j=4: substring="bba", sorted="abb", count=2
            // i=0, j=4: substring="abba", sorted="aabb", count=1
            // So for "abba", it should return "b".
            if (!"b".equals(got)) {
                throw new AssertionError("Test failed for 'abba'. Expected 'b', got " + got);
            }
        }

        System.out.println("ok - Challenge 005 Task 2 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length != 1) {
            System.err.println("Usage: java Challenge005Task2 <string>");
            System.exit(1);
        }

        System.out.println(findMostAnagrams(args[0]));
    }
}
