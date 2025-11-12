import java.util.ArrayList;
import java.util.List;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(format_phone_number("1-23-45-6"));
    System.out.println(format_phone_number("1234"));
    System.out.println(format_phone_number("12 345-6789"));
    System.out.println(format_phone_number("123 4567"));
    System.out.println(format_phone_number("123 456-78"));
  }

  private static String format_phone_number(String phone) {
    phone = phone.replace("-", "").replace(" ", "");
    int n = phone.length();
    List<String> res = new ArrayList<>();
    for (int i = 0; i < n / 3; ++i) {
      res.add(phone.substring(i * 3, i * 3 + 3));
    }
    if (n % 3 == 1) {
      res.set(res.size() - 1, res.get(res.size() - 1).substring(0, 2));
      res.add(phone.substring(n - 2));
    } else if (n % 3 == 2) {
      res.add(phone.substring(n - 2));
    }
    return String.join("-", res);
  }
}
