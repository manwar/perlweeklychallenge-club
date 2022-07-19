package theweeklychallenge;

/*

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #1: Disarium Numbers

    Write a script to generate first 19 Disarium Numbers.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/DisariumNumbers.java
    mohammad-anwar/java$ java  theweeklychallenge.DisariumNumbers

*/

import java.lang.Math;
import java.util.Arrays;
import java.util.ArrayList;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class DisariumNumbers extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.DisariumNumbers.class);
    }

    public void testDisariumNumbers() {
        Integer[] got = disariumNumbers(19);
        Integer[] exp = {0,1,2,3,4,5,6,7,8,9,89,135,175,518,598,1306,1676,2427,2646798};
        assertEquals(Arrays.toString(exp), Arrays.toString(got));
    }

    public static boolean isDisariumNumber(int n) {
        char[] digits = String.valueOf(n).toCharArray();
        int i = 0;
        int s = 0;
        while (i < digits.length) {
            s += (int) Math.pow(Character.getNumericValue(digits[i]), (i+1));
            i++;
        }

        return s == n;
    }

    public static Integer[] disariumNumbers(int n) {
        int i = 0;
        ArrayList<Integer> dn = new ArrayList<Integer>();
        while (dn.size() < n) {
            if (isDisariumNumber(i)) {
                dn.add(i);
            }
            i++;
        }

        return dn.toArray(new Integer[dn.size()]);
    }
}
