import java.util.Optional;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(reverse_equals(new int[]{3, 2, 1, 4}, new int[]{1, 2, 3, 4}));
    System.out.println(reverse_equals(new int[]{1, 3, 4}, new int[]{4, 1, 3}));
    System.out.println(reverse_equals(new int[]{2}, new int[]{2}));
  }

  private static boolean reverse_equals(int[] src, int[] target) {
    if (src.length != target.length) return false;
    Optional<Integer> from = Optional.empty(), to = Optional.empty();

    for (int i = 0; i < src.length; ++i) {
      if (src[i] != target[i]) {
        from = Optional.of(i);
        break;
      }
    }

    if (from.isEmpty()) return true;
    for (int i = src.length - 1; i > from.get(); --i) {
      if (src[i] != target[i]) {
        to = Optional.of(i);
        break;
      }
    }

    for (int i = 0; i < to.get() - from.get(); ++i) {
      if (src[from.get() + i] != target[to.get() - i]) return false;
    }

    return true;
  }
}

