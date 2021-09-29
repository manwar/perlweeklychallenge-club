// The Weekly Challenge - 132
// Task 1 Mirror Dates
// Usage: java MirrorDates YYYY MM DD

import java.time.LocalDate;
import java.time.YearMonth;

public class MirrorDates
{
    public static void main(String[] args)
    {
        int year = Integer.parseInt(args[0]);
        int month = Integer.parseInt(args[1]);
        int day = Integer.parseInt(args[2]);
        
        mirror_dates(year, month, day);
    }

    public static void mirror_dates (int birth_year,int birth_month, int birth_day) {
        LocalDate my_today = LocalDate.of(2021,9,22);
        LocalDate birthday = LocalDate.of(birth_year, birth_month, birth_day);
        long y1 = my_today.toEpochDay() - birthday.toEpochDay(); 
        LocalDate d_senior = birthday.minusDays(y1);
        LocalDate d_junior = my_today.plusDays(y1);
        System.out.println(d_senior);
        System.out.println(d_junior);
    }
}
