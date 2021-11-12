import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.EnumSet;
import java.util.Scanner;
import java.util.Set;

public class Workdays {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the year");
        final int year = scanner.nextInt();
        System.out.println("Number of workdays: " + findNumberOfWorkdays(year));
    }

    private static long findNumberOfWorkdays(int year) {
        final LocalDate start = LocalDate.of(year, 1, 1);
        final LocalDate end = LocalDate.of(year, 12, 31);
        Set<DayOfWeek> weekend = EnumSet.of(DayOfWeek.SATURDAY, DayOfWeek.SUNDAY) ;
        return start.datesUntil(end).filter(date -> !weekend.contains(date.getDayOfWeek())).count() + 1;
    }
}
