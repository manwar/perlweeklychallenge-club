package theweeklychallenge;

/*

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #2: Perfect Totient Numbers

    Write a script to generate first 20 Perfect Totient Numbers.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/FirstPerfectTotient.java
    mohammad-anwar/java$ java  theweeklychallenge.FirstPerfectTotient

*/

import java.util.Arrays;
import java.util.ArrayList;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class FirstPerfectTotient extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.FirstPerfectTotient.class);
    }

    public void testFirstPerfectTotient() {
        Integer[] got = firstPerfectTotient(20);
        Integer[] exp = {
            3, 9, 15, 27, 39, 81, 111, 183, 243,
            255, 327, 363, 471, 729, 2187, 2199,
            3063, 4359, 4375, 5571
        };

        assertEquals(Arrays.toString(exp), Arrays.toString(got));
    }

    public static int gcd(int m, int n) {
        return n == 0 ? m : gcd(n, m % n);
    }

    public static boolean isCoprime(int m, int n) {
        return gcd(m, n) == 1;
    }

    public static boolean isPerfectTotient(int n) {
        int i = n;
        int s = 0;
        while (i >= 1) {
            ArrayList<Integer> coprimes = new ArrayList<Integer>();
            for (int j = 1; j < i; j++) {
                if (isCoprime(j, i)) {
                    coprimes.add(j);
                }
            }
            i = coprimes.size();
            s = s + i;
        }

        return n == s;
    }

    public static Integer[] firstPerfectTotient(int n) {
        ArrayList<Integer> fpt = new ArrayList<Integer>();

        int i  = 1;
        while (fpt.size() < n) {
            if (isPerfectTotient(i)) {
                fpt.add(i);
            }
            i++;
        }

        return fpt.toArray(new Integer[fpt.size()]);
    }
}
