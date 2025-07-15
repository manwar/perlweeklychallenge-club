import java.util.Arrays;
import java.util.stream.Collectors;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(title_capital("PERL IS gREAT"));
    System.out.println(title_capital("THE weekly challenge"));
    System.out.println(title_capital("YoU ARE A stAR"));
  }

  private static String title_capital(String str) {
    return Arrays.stream(str.split(" "))
      .map(w -> w.length() < 3 ? w.toLowerCase()
        : w.substring(0, 1).toUpperCase() + w.substring(1).toLowerCase())
      .collect(Collectors.joining(" "));
  }
}
