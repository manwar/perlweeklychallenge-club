package theweeklychallenge;

/*

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #1: Last Sunday

    Write a script to list Last Sunday of every month in the given year.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/LastSunday.java
    mohammad-anwar/java$ java  theweeklychallenge.LastSunday

*/

import java.util.Arrays;
import java.util.ArrayList;
import java.time.LocalDate;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class LastSunday extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.LastSunday.class);
    }

    public void testLastSunday() {
        String[] got = allLastSundayOf(2022);
        String[] exp = {
            "2022-01-30", "2022-02-27", "2022-03-27", "2022-04-24",
            "2022-05-29", "2022-06-26", "2022-07-31", "2022-08-28",
            "2022-09-25", "2022-10-30", "2022-11-27", "2022-12-25",
        };

        assertEquals(Arrays.toString(exp), Arrays.toString(got));
    }

    public static String[] allLastSundayOf(int year) {
        ArrayList<String> ls = new ArrayList<String>();
        for(int month = 1; month <= 12; month++) {
            ls.add(lastSundayOf(month, year));
        }

        return ls.toArray(new String[ls.size()]);
    }

    public static String lastSundayOf(int month, int year) {
        LocalDate date = LocalDate.of(year, month, 1)
                                  .plusMonths(1)
                                  .minusDays(1);

        int dow = date.getDayOfWeek().getValue();

        if (dow == 7) {
            return date.toString();
        }
        else {
            return date.minusDays(dow).toString();
        }
    }
}
