import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(balls_and_boxes("G0B1R2R0B0"));
    System.out.println(balls_and_boxes("G1R3R6B3G6B1B6R1G3"));
    System.out.println(balls_and_boxes("B3B2G1B3"));
  }

  private static int balls_and_boxes(String str) {
    int sum = 0;
    Map<Character, StringBuilder> h = new HashMap<>();
    for (int i = 0; i < str.length(); i += 2) {
      char c = str.charAt(i), b = str.charAt(i + 1);
      h.computeIfAbsent(b, _ -> new StringBuilder()).append(c);
    }
    for (StringBuilder sb : h.values()) {
      if (Stream.of("R", "G", "B").allMatch(sb.toString()::contains))
        sum++;
    }
    return sum;
  }
}
