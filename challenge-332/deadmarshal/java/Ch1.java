import java.util.ArrayList;
import java.util.List;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(binary_date("2025-07-26"));
    System.out.println(binary_date("2000-02-02"));
    System.out.println(binary_date("2024-12-31"));
  }

  private static String binary_date(String date) {
    List<String> res = new ArrayList<>();
    for (var s : date.split("-")) {
      int e = Integer.parseInt(s);
      res.add(Integer.toBinaryString(e));
    }
    return String.join("-", res);
  }
}
