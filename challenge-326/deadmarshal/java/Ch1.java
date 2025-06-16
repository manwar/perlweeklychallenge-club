import java.time.LocalDate;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(day_of_the_year("2025-02-02"));
    System.out.println(day_of_the_year("2025-04-10"));
    System.out.println(day_of_the_year("2025-09-07"));
  }

  private static int day_of_the_year(String date) {
    return LocalDate.parse(date).getDayOfYear();
  }
}