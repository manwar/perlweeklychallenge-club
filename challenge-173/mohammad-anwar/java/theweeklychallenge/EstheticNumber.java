package theweeklychallenge;

/*

Week 173:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-173

Task #1: Esthetic Number

    You are given a positive integer, $n.

    Write a script to find out if the given number is Esthetic Number.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/EstheticNumber.java
    mohammad-anwar/java$ java  theweeklychallenge.EstheticNumber

*/

import java.lang.Math;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class EstheticNumber extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.EstheticNumber.class);
    }

    public void testEstheticNumber() {
        assertTrue(isEstheticNumber(5456));
        assertFalse(isEstheticNumber(120));
    }

    public static boolean isEstheticNumber(int n) {
        String s = Integer.toString(n);
        int i = 1;
        while (i < s.length()) {
            if (Math.abs((int)(s.charAt(i-1)) - (int)(s.charAt(i))) != 1) {
                return false;
            }
            i++;
        }

        return true;
    }
}
