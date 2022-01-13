package theweeklychallenge;

/*

Week 139:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-139

Task #1: JortSort

    You are given a list of numbers.

    Write a script to implement JortSort. It should return true/false depending if the given list of numbers are already sorted.

*/

import java.util.Arrays;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class JortSort extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(theweeklychallenge.JortSort.class);
    }

    public void testJortSort() {
        assertEquals(jortSort(new int[] {1,2,3,4,5}), 1);
        assertEquals(jortSort(new int[] {1,3,4,2,5}), 0);
    }

    public static int jortSort(int[] n) {
        int[] s = n.clone();
        Arrays.sort(s);

        for(int i = 0; i < n.length; i++) {
            if (n[i] != s[i]) {
                return 0;
            }
        }

        return 1;
    }
}
