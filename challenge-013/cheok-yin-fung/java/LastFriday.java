// The Weekly Challenge - 013 
// Task 1 Last Friday
// attempt: May 09th, 2021
// from: C.-Y. Fung
// Usage: java LastFriday [year]
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.DayOfWeek;
public class LastFriday 
{
    public static void main(String[] args) 
    {
        int year = 2008;   // default value
        if (args.length != 0) 
            year = Integer.parseInt(args[0]);
        if (year < 1900) {
            System.out.println("Sorry, it's too long ago.");
            System.exit(0);
        }
        System.out.println("Year: " + year + "\n");
        for (int month = 1; month <= 12; month++) {
            YearMonth temp = YearMonth.of(year, month);
            LocalDate target = 
              LocalDate.of(year , month , temp.lengthOfMonth());
            while ( target.getDayOfWeek() != DayOfWeek.FRIDAY ) {
                target = target.minusDays(1);
            }
            System.out.println(target);
        }
    }
}
