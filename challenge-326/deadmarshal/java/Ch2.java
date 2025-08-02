import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(decompressed_list(new int[]{1, 3, 2, 4}));
    System.out.println(decompressed_list(new int[]{1, 1, 2, 2}));
    System.out.println(decompressed_list(new int[]{3, 1, 3, 2}));
  }

  private static List<Integer> decompressed_list(int[] arr) {
    return IntStream.range(0, arr.length / 2)
      .mapToObj(i -> Arrays.stream(new int[arr[2 * i]])
        .map(val -> arr[2 * i + 1])
        .boxed())
      .flatMap(s -> s)
      .collect(Collectors.toList());
  }
}
