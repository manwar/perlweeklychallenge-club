package theweeklychallenge;

/*

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #1: Divisible Pairs

    You are given list of integers @list of size $n and divisor $k.

    Write a script to find out count of pairs in the given list that
    satisfies the following rules.

    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list
    b) list[i] + list[j] is divisible by k

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/DivisiblePairs.java
    mohammad-anwar/java$ java  theweeklychallenge.DivisiblePairs

*/

import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class DivisiblePairs extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.DivisiblePairs.class
        );
    }

    public void testDivisiblePairs() {
        assertEquals(2, countDivisiblePairs(new int[]{4, 5, 1, 6}, 2));
        assertEquals(2, countDivisiblePairs(new int[]{1, 2, 3, 4}, 2));
        assertEquals(2, countDivisiblePairs(new int[]{1, 3, 4, 5}, 3));
        assertEquals(2, countDivisiblePairs(new int[]{5, 1, 2, 3}, 4));
        assertEquals(1, countDivisiblePairs(new int[]{7, 2, 4, 5}, 4));
    }

    public static int countDivisiblePairs(int[] array, int k) {
        int count = 0;
        int size  = array.length;
        for (int i = 0; i < size-1; i++) {
            for (int j = i+1; j < size; j++) {
                if ((array[i] + array[j]) % k == 0) {
                    count++;
                }
            }
        }

        return count;
    }

}
