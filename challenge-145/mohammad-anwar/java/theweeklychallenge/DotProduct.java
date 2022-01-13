package theweeklychallenge;

/*

Week 145:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-145

Task #1: Dot Product

    You are given 2 arrays of same size, @a and @b.

    Write a script to implement Dot Product.

*/

import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class DotProduct extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(theweeklychallenge.DotProduct.class);
    }

    public void testDotProduct() {
        assertEquals(32, dotProduct(new int[] {1,2,3}, new int[] {4,5,6}));
    }

    public static int dotProduct(int[] a, int[] b) {

        int dp = 0;
        if (a.length == b.length) {
            for(int i = 0; i < a.length; i++) {
                dp += a[i] * b[i];
            }
        }

        return dp;
    }
}
