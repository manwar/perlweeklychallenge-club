// The Weekly Challenge - 138
// Task 1 Work Days
// Usage: java WorkDays YYYY

import java.time.LocalDate;

public class WorkDays
{
    public static void main(String[] args)
    {
        int year = Integer.parseInt(args[0]);
        System.out.println(numOfWorkDays(year));

        testing();
        benchmark();

    }

    public static void testing()
    {
        for (int i = 1900; i <= 2400; i++)
        {
            if (numOfWorkDays(i) != simple_days_count(i))
                System.out.println("big event in " + i);
        }
    }

    public static int numOfWorkDays (int year) {
        LocalDate MondayJan = LocalDate.of(year, 1, 1);
        int ans = 0;
        int ga = gd(MondayJan);
        while (ga != 1) 
        {
            if (ga <= 5 && ga >= 2) 
                ans++;
            MondayJan = MondayJan.plusDays(1);
            ga = gd(MondayJan);
        }
        LocalDate lastDay = MondayJan.plusWeeks(51);
        ans += 51*5;
        int gb = gd(lastDay);
        while (lastDay.getDayOfYear() < lastDay.lengthOfYear()) 
        {
            if (gb <= 5 && gb >= 1)
                ans++;
            lastDay = lastDay.plusDays(1);
            gb = gd(lastDay);
        }
        ans += gb <= 5 ? 1 : 0;
        return ans;
    }


    public static int simple_days_count(int year)
    {
        int i = 0;
        LocalDate my_day = LocalDate.of(year, 1, 1);
        while (my_day.getYear() == year)
        {
            if (gd(my_day) != 6 && gd(my_day) != 7)
            {
                i++;
            }
            my_day = my_day.plusDays(1);
        }
        return i;
    }


    public static int gd(LocalDate date)
    {
        var a = date.getDayOfWeek();
        switch(a)
        {
            case MONDAY: return 1;
            case TUESDAY: return 2;
            case WEDNESDAY: return 3;
            case THURSDAY: return 4;
            case FRIDAY: return 5;
            case SATURDAY: return 6;
            case SUNDAY: return 7;
        }
        return 0;
    }

    public static void benchmark()
    {
        long time_0 = System.nanoTime();
        for (int i = 1975; i < 2400; i++) {
            simple_days_count(i);
        }
        long time_1 = System.nanoTime();
        for (int i = 1975; i < 2400; i++) {
            numOfWorkDays(i);
        }
        long time_2 = System.nanoTime();
        System.out.println("simple_days_count " + (time_1 - time_0));
        System.out.println("numOfWorkDays " + (time_2 - time_1));

        // Output:
        // simple_days_count  10398009
        // numOfWorkDays        344198

    }

}
