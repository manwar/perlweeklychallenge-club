package theweeklychallenge;

/*

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task 2: Reversible Numbers

    Write a script to find out all Reversible Numbers below 100.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/ReversibleNumbers.java
    mohammad-anwar/java$ java  theweeklychallenge.ReversibleNumbers

*/

import java.util.Arrays;
import java.util.ArrayList;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class ReversibleNumbers extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.ReversibleNumbers.class);
    }

    public void testReversibleNumbers() {
        Integer[] exp = {
            10, 12, 14, 16, 18, 21, 23, 25, 27,
            30, 32, 34, 36, 41, 43, 45, 50, 52,
            54, 61, 63, 70, 72, 81, 90
        };
        Integer[] got = reversibleNumbersBelow(100);

        assertEquals(Arrays.toString(exp), Arrays.toString(got));
    }

    public static Integer[] reversibleNumbersBelow(int n) {
        ArrayList<Integer> rn = new ArrayList<Integer>();
        for(int i = 1; i <= n; i++) {
            if (hasAllOddDigits(i + reverseInt(i))) {
                rn.add(i);
            }
        }

        return rn.toArray(new Integer[rn.size()]);
    }

    public static int reverseInt(int num) {
        StringBuffer stringBuffer = new StringBuffer(String.valueOf(num));
        stringBuffer.reverse();
        return Integer.parseInt(stringBuffer.toString());
    }

    public static boolean hasAllOddDigits(int n) {
        char[] digits = Integer.toString(n).toCharArray();
        for(int i = 0; i < digits.length; i++) {
            int d = (int) digits[i];
            if (d % 2 == 0) {
                return false;
            }
        }

        return true;
    }
}
