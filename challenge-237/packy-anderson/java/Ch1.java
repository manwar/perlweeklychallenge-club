import java.util.Calendar;  
import java.text.SimpleDateFormat;

class seizeTheDay {
  public int    day;
  public String description;

  public seizeTheDay(
    int year,
    int month,
    int weekday_of_month,
    int day_of_week
  ) {
    // object for the first day of the specified month
    Calendar t = Calendar.getInstance();
    t.set(year, month - 1, 1);

    // find the FIRST instance of the desired day of the week
    while (t.get(Calendar.DAY_OF_WEEK) != day_of_week+1) {
      t.add(Calendar.DATE, 1);
    }

    String month_str =
      new SimpleDateFormat("MMM").format(t.getTime());
    String dow_str =
      new SimpleDateFormat("EEE").format(t.getTime());
    int count = 1;

    // now roll forward through the month until the desired
    // weekday of the month
    while (
      // we're still in the desired month
      t.get(Calendar.MONTH) == month - 1
      && 
      // we haven't reached the desired weekday of the month
      count < weekday_of_month
    ) {
      t.add(Calendar.DATE, 7);
      count++;
    }
    if (t.get(Calendar.MONTH) != month - 1) {
      this.day = 0;
      this.description = String.format(
        "There isn't a %s %s in %s %d",
        this.ord_suffix(weekday_of_month),
        dow_str,
        month_str,
        year
      );
    }
    else {
      this.day = t.get(Calendar.DATE);
      this.description = String.format(
        "The %s %s of %s %d is the %s",
        this.ord_suffix(weekday_of_month),
        dow_str,
        month_str,
        year,
        this.ord_suffix(this.day)
      );
    }
  }

  private String ord_suffix(int num) {
    // quick function to add an ordinal suffix
    // to a number
    if (num == 11 || num == 12 | num == 13) {
      return num + "th";
    }
    else {
      switch (num % 10) {
        case 1:  return num + "st";
        case 2:  return num + "nd";
        case 3:  return num + "rd";
        default: return num + "th";
      }
    }
  }
}

public class Ch1 {
  public static void solution(
    int year,
    int month,
    int weekday_of_month,
    int day_of_week
  ) {
    String format = "Input: Year = %d, Month = %d, "
                  + "Weekday of month = %d, day of week = %d";
    System.out.println(String.format(
      format, year, month, weekday_of_month, day_of_week
    ));
    seizeTheDay d = new seizeTheDay(year, month, weekday_of_month, day_of_week);
    System.out.println(String.format("Output: %d", d.day));
    System.out.println(String.format("\n%s", d.description));
  }

  public static void main(String[] args) {
    System.out.println("Example 1:");
    solution(2024, 4, 3, 2);

    System.out.println("\nExample 2:");
    solution(2025, 10, 2, 4);

    System.out.println("\nExample 3:");
    solution(2026, 8, 5, 3);
  }
}
