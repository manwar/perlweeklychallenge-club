package theweeklychallenge;

/*

Week 137:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-137

Task #1: Long Year

    Write a script to find all the years between 1900 and 2100 which is a Long Year.

*/

import java.util.*;
import java.time.Year;
import java.time.LocalDate;
import java.time.temporal.IsoFields;

import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class LongYear extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(theweeklychallenge.LongYear.class);
    }

    public void testLongYear() {

        List<Integer> exp = Arrays.asList(
                      1903, 1908, 1914, 1920, 1925,
                      1931, 1936, 1942, 1948, 1953,
                      1959, 1964, 1970, 1976, 1981,
                      1987, 1992, 1998, 2004, 2009,
                      2015, 2020, 2026, 2032, 2037,
                      2043, 2048, 2054, 2060, 2065,
                      2071, 2076, 2082, 2088, 2093,
                      2099 );

        List<Integer> got = new ArrayList<Integer>();
        for (int y = 1900; y <= 2100; y++) {
            if (isLongYear(y)) {
                got.add(y);
            }
        }

        assertTrue(got.equals(exp));
    }

    public static boolean isLongYear(int y) {
        if (getWeekNumber(y, 12, 31) == 53) {
            if (Year.isLeap(y)) {
                if (getDayOfWeek(y, 1, 1) == 3
                    || getDayOfWeek(y, 12, 31) == 5) {
                    return true;
                }
            }
            else {
                if (getDayOfWeek(y, 1, 1) == 4
                    || getDayOfWeek(y, 12, 31) == 4) {
                    return true;
                }
            }
        }

        return false;
    }

    public static int getDayOfWeek(int year, int month, int day) {
        return LocalDate.of(year, month, day).getDayOfWeek().getValue();
    }

    public static int getWeekNumber(int year, int month, int day) {
        return LocalDate.of(year, month, day).get(IsoFields.WEEK_OF_WEEK_BASED_YEAR);
    }
}
