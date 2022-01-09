package theweeklychallenge;

/*

Week 146:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-146

Task #1: 10001st Prime Number

    Write a script to generate the 10001st prime number.

*/

import java.lang.Math;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class FindPrime extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(theweeklychallenge.FindPrime.class);
    }

    public void testFindPrime() {
        assertEquals(104743, findPrime(10001));
    }

    public static int findPrime(int count) {

        int c = 0;
        int n = 2;
        while (c <= count) {
            if (isPrime(n)) {
                if (++c == count) {
                    return n;
                }
            }
            n++;
        }

        return 0;
    }

    public static boolean isPrime(int n) {

        for(int i=2; i <= Math.sqrt(n); i++) {
            if ((n % i) == 0) {
                return false;
            }
        }

        return true;
    }
}
