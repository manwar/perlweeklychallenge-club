import java.util.LinkedHashSet;
import java.util.Set;

/**
 * Perl Weekly Challenge 005 - Task 1.
 * Print all anagrams for a given word.
 */
class Challenge005Task1 {
    private static Set<String> getAnagrams(String word) {
        LinkedHashSet<String> out = new LinkedHashSet<String>();
        permute(word.toCharArray(), 0, out);
        return out;
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

    private static void runTests() {
        Set<String> got = getAnagrams("cat");
        LinkedHashSet<String> expected = new LinkedHashSet<String>();
        expected.add("cat");
        expected.add("cta");
        expected.add("act");
        expected.add("atc");
        expected.add("tca");
        expected.add("tac");

        if (!got.equals(expected)) {
            throw new AssertionError("Unexpected anagrams: " + got);
        }
        System.out.println("ok - challenge 005 task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length != 1) {
            throw new IllegalArgumentException("Usage: java Challenge005Task1 <word>");
        }

        for (String anagram : getAnagrams(args[0])) {
            System.out.println(anagram);
        }
    }
}
