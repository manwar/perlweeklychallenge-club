import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Ch1 {
    public static HashMap<Character, Integer> charFrequency(String word) {
        HashMap<Character, Integer> freq = new HashMap<Character, Integer>();
        for (int i=0; i < word.length(); i++) {
            char c = word.charAt(i);
            freq.put(c, freq.getOrDefault(c,0)+1);
        }
        return freq;
    }

    public static ArrayList<String> commonCharacters(String[] words) {
        // get the character frequencies for each word in words
        ArrayList<HashMap<Character, Integer>> freq =
                new ArrayList<HashMap<Character, Integer>>();
        for (String word : words) {
            freq.add(charFrequency(word));
        }
        // grab the character frequency map for the first word
        HashMap<Character, Integer> first = freq.remove(0);
        // now check the characters in the first word against
        // the characters in all the subsequent words
        Set<Character> keys = new HashSet<>(first.keySet());
        for (Character c : keys) {
            for (HashMap<Character, Integer> subsequent : freq) {
                if (! subsequent.containsKey(c)) {
                    // this character isn't in subsequent words,
                    // so let's remove it from the frequency map
                    // of the first word
                    first.remove(c);
                }
                else {
                    // the character IS in subsequent words,
                    // so let's set the frequency count to be
                    // the minimum count found in those words
                    first.put(c, Math.min(first.get(c), subsequent.get(c)));
                }
            }
        }
        // now we generate a list of characters in the order they
        // appear in the first word
        ArrayList<String> output = new ArrayList<String>();
        // once again, loop over the characters in the first word
        for (int i=0; i < words[0].length(); i++) {
            Character c = words[0].charAt(i);
            if (first.containsKey(c)) {
                if (first.get(c) > 1) {
                    first.put(c, first.get(c) - 1);
                }
                else {
                    first.remove(c);
                }
                output.add("" + c);
            }
        }
        return output;
    }

    public static void solution(String[] words) {
        System.out.println("Input: @words = (\"" + String.join("\", \"", words) + "\")");
        ArrayList<String> output = commonCharacters(words);
        System.out.println("Output: (\"" + String.join("\", \"", output) + "\")");
    }

    public static void main(String[] args) {
        System.out.println("Example 1:");
        solution(new String[] {"java", "javascript", "julia"});

        System.out.println("\nExample 2:");
        solution(new String[] {"bella", "label", "roller"});

        System.out.println("\nExample 3:");
        solution(new String[] {"cool", "lock", "cook"});
    }
}