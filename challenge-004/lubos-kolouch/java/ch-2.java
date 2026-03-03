import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Perl Weekly Challenge 004 - Task 2.
 * Print words that can be built from provided letters.
 */
class Challenge004Task2 {
    private static boolean canBuildWord(String word, String letters) {
        int[] need = new int[26];
        int[] have = new int[26];

        for (int i = 0; i < letters.length(); i++) {
            char ch = Character.toLowerCase(letters.charAt(i));
            if (ch >= 'a' && ch <= 'z') {
                have[ch - 'a']++;
            }
        }

        for (int i = 0; i < word.length(); i++) {
            char ch = Character.toLowerCase(word.charAt(i));
            if (ch < 'a' || ch > 'z') {
                return false;
            }
            int idx = ch - 'a';
            need[idx]++;
            if (need[idx] > have[idx]) {
                return false;
            }
        }

        return true;
    }

    private static List<String> matchingWords(String letters, List<String> words) {
        List<String> out = new ArrayList<String>();
        for (String word : words) {
            if (canBuildWord(word, letters)) {
                out.add(word);
            }
        }
        return out;
    }

    private static void runTests() {
        List<String> got1 = matchingWords("abc", Arrays.asList("cab", "baa", "Dad"));
        if (!got1.equals(Arrays.asList("cab"))) {
            throw new AssertionError("Unexpected result: " + got1);
        }

        List<String> got2 = matchingWords("aAbB", Arrays.asList("ab", "bA", "aba", "BBa"));
        if (!got2.equals(Arrays.asList("ab", "bA", "aba", "BBa"))) {
            throw new AssertionError("Unexpected result: " + got2);
        }

        System.out.println("ok - challenge 004 task 2 tests passed");
    }

    private static List<String> readWordsFromStdin() throws IOException {
        List<String> words = new ArrayList<String>();
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in, StandardCharsets.UTF_8));
        String line;
        while ((line = reader.readLine()) != null) {
            if (!line.isEmpty()) {
                words.add(line);
            }
        }
        return words;
    }

    public static void main(String[] args) throws IOException {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length < 1 || args.length > 2) {
            throw new IllegalArgumentException("Usage: java Challenge004Task2 <letters> [words-file]");
        }

        String letters = args[0];
        List<String> words;
        if (args.length == 2) {
            words = Files.readAllLines(Paths.get(args[1]), StandardCharsets.UTF_8);
        } else {
            words = readWordsFromStdin();
        }

        for (String word : matchingWords(letters, words)) {
            System.out.println(word);
        }
    }
}
