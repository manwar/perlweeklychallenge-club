package theweeklychallenge;

/*

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task #1: Permuted Multiples

    Write a script to find the smallest integer x such that x, 2x,
    3x, 4x, 5x and 6x are permuted multiples of each other.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/PermutedMultiples.java
    mohammad-anwar/java$ java  theweeklychallenge.PermutedMultiples

*/

import java.util.Arrays;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class PermutedMultiples extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.PermutedMultiples.class);
    }

    public void testPermutedMultiples() {
        assertEquals(142857, smallestPermutedMultiples());
    }

    public static int smallestPermutedMultiples() {
        int i = 10;
        while (true) {
            boolean found = true;
            for (int j = 2; j <= 6; j++) {
                if (!hasSameDigits(i, i * j)) {
                    found = false;
                    break;
                }
            }

            if (found) {
                return i;
            }

            i += 1;
        }
    }

    public static boolean hasSameDigits(int m, int n) {
        char[] x = Integer.toString(m).toCharArray();
        char[] y = Integer.toString(n).toCharArray();

        Arrays.sort(x);
        Arrays.sort(y);

        return Arrays.equals(x, y);
    }
}
