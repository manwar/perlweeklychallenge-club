package theweeklychallenge;

/*

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #1: Damm Algorigthm

    You are given a positive number, $n.

    Write a script to validate the given number against the included
    check digit.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/DammAlgorithm.java
    mohammad-anwar/java$ java  theweeklychallenge.DammAlgorithm

*/

import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class DammAlgorithm extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.DammAlgorithm.class);
    }

    public void testDammAlgorithm() {
        assertTrue(isValidCheckDigit(5724));
        assertFalse(isValidCheckDigit(5727));
    }

    public static boolean isValidCheckDigit(int num) {
        Integer[][] op_table = {
            new Integer[] { 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 },
            new Integer[] { 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 },
            new Integer[] { 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 },
            new Integer[] { 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 },
            new Integer[] { 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 },
            new Integer[] { 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 },
            new Integer[] { 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 },
            new Integer[] { 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 },
            new Integer[] { 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 },
            new Integer[] { 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 },
        };

        int[] n = getDigitsOf(num);
        int   c = n[n.length - 1];
        int   i = 0;
        for (int j = 0; j < n.length - 1; j++) {
            i = op_table[i][n[j]];
        }

        return i == c;
    }

    public static int[] getDigitsOf(int number) {
        String num  = String.valueOf(number);
        int array[] = new int[num.length()];

        for (int i = 0; i < num.length(); i++) {
            array[i] = Character.getNumericValue(num.charAt(i));
        }

        return array;
    }
}
