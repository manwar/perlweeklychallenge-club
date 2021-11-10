package theweeklychallenge;

/*

Week 138:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-138

Task #1: Wrokdays

    You are given a year in 4-digits form. Write a script to calculate the total number of workdays in the given year.

*/

import java.time.LocalDate;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class Workdays extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(theweeklychallenge.Workdays.class);
    }

    public void testWorkdays() {
        assertEquals(workdays(2021), 261);
        assertEquals(workdays(2020), 262);
    }

    public static int workdays(int year) {
        int d = 1;
        int m = 1;
        int y = year;

        int workdays = 0;
        while (year == y) {
            LocalDate date =  LocalDate.of(y, m, d);
            if (date.getDayOfWeek().getValue() < 6) workdays += 1;

            date = date.plusDays(1);
            y = date.getYear();
            m = date.getMonthValue();
            d = date.getDayOfMonth();
        }

        return workdays;
    }
}
