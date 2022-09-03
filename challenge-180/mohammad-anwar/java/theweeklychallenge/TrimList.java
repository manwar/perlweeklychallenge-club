package theweeklychallenge;

/*

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #2: Trim List

    You are given list of numbers, @n and an integer $i.

    Write a script to trim the given list where element is less than
    or equal to the given integer.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/TrimList.java
    mohammad-anwar/java$ java  theweeklychallenge.TrimList

*/

import java.util.Map;
import java.util.TreeMap;
import java.util.Arrays;
import java.util.ArrayList;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class TrimList extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.TrimList.class);
    }

    public void testTrimListExample1() {
        int i       = 3;
        Integer[] n = {1, 4, 2, 3, 5};
        Integer[] got = trimList(i, n);
        Integer[] exp = {4, 5};
        assertEquals(Arrays.toString(exp), Arrays.toString(got));
    }

    public void testTrimListExample2() {
        int i       = 4;
        Integer[] n = {9, 0, 6, 2, 3, 8, 5};
        Integer[] got = trimList(i, n);
        Integer[] exp = {9, 6, 8, 5};
        assertEquals(Arrays.toString(exp), Arrays.toString(got));
    }

    public static Integer[] trimList(int i, Integer[] n) {
        ArrayList<Integer> list = new ArrayList<Integer>();
        for (int j : n) {
            if (j > i) {
            	list.add(j);
            }
        }

        return list.toArray(new Integer[list.size()]);
    }
}
