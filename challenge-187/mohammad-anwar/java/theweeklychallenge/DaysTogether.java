package theweeklychallenge;

/*

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #1: Days Together

    Two friends, Foo and Bar gone on holidays seperately to the same
    city. You are given their schedule i.e. start date and end date.

    To keep the task simple, the date is in the form 'DD-MM' and all
    dates belong to the  same calendar year i.e. between '01-01' and
    '31-12'.

    Also the year is non-leap year and both dates are inclusive.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/DaysTogether.java
    mohammad-anwar/java$ java  theweeklychallenge.DaysTogether

*/

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class DaysTogether extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.DaysTogether.class
        );
    }

    public void testDaysTogether() {
        assertEquals(4, daysTogether("12-01","20-01","15-01","18-01"));
        assertEquals(0, daysTogether("02-03","12-03","13-03","14-03"));
        assertEquals(2, daysTogether("02-03","12-03","11-03","15-03"));
        assertEquals(4, daysTogether("30-03","05-04","28-03","02-04"));
    }

    public static int daysTogether(
        String sd1, String ed1, String sd2,    String ed2) {
        LocalDate _sd1 = _date(sd1);
        LocalDate _ed1 = _date(ed1);
        LocalDate _sd2 = _date(sd2);
        LocalDate _ed2 = _date(ed2);

        int days = 0;

        if (_ed1.compareTo(_sd2) < 0) {
            return days;
        }

        if (_sd1.compareTo(_sd2) > 0) {
            days = _daysTogether(_sd1, _ed1, _ed2);
        }
        else if (_ed2.compareTo(_sd2) > 0) {
            days = _daysTogether(_sd2, _ed1, _ed2);
        }

        return days;
    }

    public static LocalDate _date(String dateStr) {
        String[] splitDate = dateStr.split("-");
        int day   = Integer.parseInt(splitDate[0]);
        int month = Integer.parseInt(splitDate[1]);

        return LocalDate.of(2022, month, day);
    }

    public static int _daysTogether(
        LocalDate from, LocalDate to, LocalDate _to) {
        if (to.compareTo(_to) > 0) {
            to = _to;
        }

        long days = ChronoUnit.DAYS.between(from, to);
        return (int)days + 1;
    }
}
