import java.util.Arrays;

public class Main {
  public static void main(String[] args) {
    int[] N = {2, 5, 4, 4, 5, 5, 2};
    int odd = Arrays.stream(N).reduce(0, (a, b) -> a ^ b);
    System.out.println(odd);
  }
}
