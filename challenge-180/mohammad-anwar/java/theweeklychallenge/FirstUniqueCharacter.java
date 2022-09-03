package theweeklychallenge;

/*

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #1: First Unique Character

    You are given a string, $s.

    Write a script to find out the first unique character in the
    given string and print its index (0-based).

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/FirstUniqueCharacter.java
    mohammad-anwar/java$ java  theweeklychallenge.FirstUniqueCharacter

*/

import java.util.Map;
import java.util.TreeMap;
import java.util.ArrayList;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class FirstUniqueCharacter extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.FirstUniqueCharacter.class);
    }

    public void testDammAlgorithm() {
        assertEquals(firstUniqueCharacter("Perl Weekly Challenge"), 0);
        assertEquals(firstUniqueCharacter("Long Live Perl"), 1);
    }

    public static int firstUniqueCharacter(String str) {
        char[] chars = str.toCharArray();
        ArrayList<Character> chars_array = new ArrayList<Character>();
        Map<Character, Integer> chars_map = new TreeMap<Character, Integer>();
        int j = 0;
        for (int i = 0; i < chars.length; i++) {
            char c = chars[i];
            if (Character.compare(c, ' ') == 0) {
                continue;
            }
            c = Character.toLowerCase(c);
            if (chars_map.containsKey(c)) {
                chars_map.put(c, chars_map.get(c) + 1);
            }
            else {
                chars_array.add(c);
                chars_map.put(c, 1);
                j++;
            }
        }

        int k = 0;
        for (char c : chars_array) {
            if (chars_map.get(c) == 1) {
                break;
            }
            k++;
        }

        return k;
    }
}
