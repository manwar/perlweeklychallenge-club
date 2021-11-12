// The Weekly Challenge - 137
// Task 1 Long Year
// Usage: java LongYear

import java.time.LocalDate;
import java.time.YearMonth;

public class LongYear
{
    public static void main(String[] args)
    {
        int c = 0;
        for(int y = 1900; y <= 2100; y++)
        {
            LocalDate fourthJan = LocalDate.of(y, 1, 4);
            int a = gdow( (fourthJan.getDayOfWeek()).toString() );
            LocalDate YearLastDay = LocalDate.of(y, 12, 31);
            int b = gdow( (YearLastDay.getDayOfWeek()).toString() );
            if (a >= 4 && b >= 4)
            {
                System.out.println(y);
                c++;
            }
        }
        System.out.println("Number of Long Years: " + c);
    }

    public static int gdow(String a)
    {
        switch(a)
        {
            case "MONDAY": return 1;
            case "TUESDAY": return 2;
            case "WEDNESDAY": return 3;
            case "THURSDAY": return 4;
            case "FRIDAY": return 5;
            case "SATURDAY": return 6;
            case "SUNDAY": return 7;
        }
        return 0;
    }
}
