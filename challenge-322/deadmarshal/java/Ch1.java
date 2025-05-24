import java.util.Stack;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(string_format("ABC-D-E-F", 3));
    System.out.println(string_format("A-BC-D-E", 2));
    System.out.println(string_format("-A-B-CD-E", 4));
  }

  private static String string_format(String s, int i) {
    s = s.replace("-", "");
    StringBuilder sb = new StringBuilder();
    int t = 0, rem = s.length() % i;
    if (rem == 0) rem = i;
    for (int j = 0; j < s.length(); ++j) {
      sb.append(s.charAt(j));
      ++t;
      if (t == rem) {
        t = 0;
        rem = i;
        if (j != s.length() - 1) sb.append('-');
      }
    }
    return sb.toString();
  }
}

