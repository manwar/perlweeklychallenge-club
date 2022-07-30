// The Weekly Challenge 175
// Task 1 Last Sunday

import java.time.LocalDate;

public class LastSunday
{

    public static void main(String[] args)
    {
        int year = Integer.parseInt(args[0]);
        for (String date_str : last_sun_year(year))
        {
            System.out.println(date_str);
        }
    }

    public static LocalDate last_sun_month (int yr, int month)
    {
        LocalDate temp = LocalDate.of(yr,month+1,1);
        return temp.minusDays(gd(temp));
    }

    public static String[] last_sun_year(int yr) 
    {
        String[] ans = new String[12];
        for (int i = 1; i<=11; i++) 
        {
            ans[i-1] = last_sun_month(yr,i).toString();
        }
        LocalDate temp = LocalDate.of(yr+1,1,1);
        ans[11] = temp.minusDays(gd(temp)).toString();
        return ans;
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


}
