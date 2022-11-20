package theweeklychallenge;

/*

Week 191:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-191

Task #1: Twice Largest

    You are given list of integers, @list.

    Write a script to find out whether the largest item in the list
    is at least twice as large as each of the other items.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/TwiceLargest.java
    mohammad-anwar/java$ java  theweeklychallenge.TwiceLargest

*/

import java.util.Arrays;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class TwiceLargest extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.TwiceLargest.class
        );
    }

    public void testTwiceLargest() {
        assertEquals(twiceLargest(new int[]{1, 2, 3, 4}), -1);
        assertEquals(twiceLargest(new int[]{1, 2, 0, 5}),  1);
        assertEquals(twiceLargest(new int[]{2, 6, 3, 1}),  1);
        assertEquals(twiceLargest(new int[]{4, 5, 2, 3}), -1);
    }

    public static int twiceLargest(int[] array) {
        Arrays.sort(array);
        int max = array[array.length-1];
        for(int i : array) {
            if (i == max)    { continue;  }
            if (i * 2 > max) { return -1; };
        }

        return 1;
    }
}
