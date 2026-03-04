import java.util.*;

/**
 * Perl Weekly Challenge 007 - Task 2.
 * Find the shortest word ladder between two words.
 */
public class Challenge007Task2 {

    public static List<String> findShortestLadder(String word1, String word2, List<String> wordList) {
        if (word1.length() != word2.length()) {
            return Collections.emptyList();
        }

        Set<String> wordSet = new HashSet<>(wordList);
        if (!wordSet.contains(word1) || !wordSet.contains(word2)) {
            return Collections.emptyList();
        }

        Queue<List<String>> queue = new LinkedList<>();
        queue.add(new ArrayList<>(Arrays.asList(word1)));

        Set<String> visited = new HashSet<>();
        visited.add(word1);

        while (!queue.isEmpty()) {
            List<String> path = queue.poll();
            String lastWord = path.get(path.size() - 1);

            if (lastWord.equals(word2)) {
                return path;
            }

            char[] chars = lastWord.toCharArray();
            for (int i = 0; i < chars.length; i++) {
                char originalChar = chars[i];
                for (char c = 'a'; c <= 'z'; c++) {
                    chars[i] = c;
                    String newWord = new String(chars);
                    if (wordSet.contains(newWord) && !visited.contains(newWord)) {
                        List<String> newPath = new ArrayList<>(path);
                        newPath.add(newWord);
                        queue.add(newPath);
                        visited.add(newWord);

                        if (newWord.equals(word2)) {
                            return newPath;
                        }
                    }
                }
                chars[i] = originalChar;
            }
        }

        return Collections.emptyList();
    }

    private static void runTests() {
        List<String> wordList = Arrays.asList("cold", "cord", "core", "care", "card", "ward", "warm", "worm");
        List<String> got = findShortestLadder("cold", "warm", wordList);
        List<String> expected = Arrays.asList("cold", "cord", "card", "ward", "warm");

        if (!got.equals(expected)) {
            throw new AssertionError("Test case 1 failed. Expected " + expected + ", got " + got);
        }
        System.out.println("ok - Challenge 007 Task 2 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length < 3) {
            System.err.println("Usage: java Challenge007Task2 <word1> <word2> <word_list_comma_separated>");
            System.exit(1);
        }

        String word1 = args[0];
        String word2 = args[1];
        List<String> wordList = Arrays.asList(args[2].split(","));

        List<String> ladder = findShortestLadder(word1, word2, wordList);
        if (ladder.isEmpty()) {
            System.out.println("No ladder found.");
        } else {
            System.out.println(String.join(",", ladder));
        }
    }
}
