package theweeklychallenge;

/*

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #2: Total Zero

    You are given two positive integers $x and $y.

    Write a script to find out the number of operations needed to
    make both ZERO. Each operator is made up either of the following:

        $x = $x - $y if $x >= $y

        or

        $y = $y - $x if $y >= $x

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/TotalZero.java
    mohammad-anwar/java$ java  theweeklychallenge.TotalZero

*/

import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class TotalZero extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.TotalZero.class
        );
    }

    public void testTotalZero() {
        assertEquals(5, totalZero(5, 4));
        assertEquals(3, totalZero(4, 6));
        assertEquals(4, totalZero(2, 5));
        assertEquals(3, totalZero(3, 1));
        assertEquals(5, totalZero(7, 4));
    }

    public static int totalZero(int x, int y) {
        int count = 0;
        while (x > 0 && y > 0) {
            if (x >= y) {
                x -= y;
            }
            else {
                y -= x;
            }
            count++;
        }

        return count;
    }

}
