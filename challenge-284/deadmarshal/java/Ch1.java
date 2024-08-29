import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(lucky_number(new int[]{2, 2, 3, 4}));
    System.out.println(lucky_number(new int[]{1, 2, 2, 3, 3, 3}));
    System.out.println(lucky_number(new int[]{1, 1, 13}));
  }

  private static int lucky_number(int[] arr) {
    Map<Integer, Integer> h = new HashMap<>();
    for (var e : arr) h.merge(e, 1, Integer::sum);
    Optional<Integer> m =
      h.keySet().stream().filter(e -> Objects.equals(h.get(e), e))
      .max(Integer::compareTo);
    return m.orElse(-1);
  }
}

