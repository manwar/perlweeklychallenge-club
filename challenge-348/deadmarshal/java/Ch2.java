import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(convert_time("02:30","02:45"));
    System.out.println(convert_time("11:55","12:15"));
    System.out.println(convert_time("09:00","13:00"));
    System.out.println(convert_time("23:45","00:30"));
    System.out.println(convert_time("14:20","15:25"));
  }

  private static int convert_time(String source,String target) {
    int a = to_min(source),b = to_min(target);
    int res = 0, d = (b - a + 1440) % 1440;
    for(int i : Arrays.asList(60,15,5,1)) {
      res += d / i;
      d %= i;
    }
    return res;
  }

  private static int to_min(String s) {
    String[] parts = s.split(":");
    int a = Integer.parseInt(parts[0]);
    int b = Integer.parseInt(parts[1]);
    return a * 60 + b;
  }
}

