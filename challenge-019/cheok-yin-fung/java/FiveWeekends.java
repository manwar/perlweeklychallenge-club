// The Weekly Challenge - 019
// Task 1 Five Weekends
// attempt: May 09th, 2021
// from: C.-Y. Fung
// Usage: java FiveWeekends [year]
import java.time.LocalDate;
import java.time.DayOfWeek;
import java.time.Month;

public class FiveWeekends
{
    public static void main(String[] args) 
    {
        int[] months = new int[] {1, 3, 5, 7, 8, 10, 12};

        for (int i = 1900; i <= 2019; i++)
            for (int M: months)
                if (LocalDate.of(i,M,1).getDayOfWeek() == DayOfWeek.FRIDAY)
                    System.out.println(i+" "+ Month.of(M));

    }
}
