import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(digit_count_value(new int[]{1, 2, 1, 0}));
    System.out.println(digit_count_value(new int[]{0, 3, 0}));
  }

  private static boolean digit_count_value(int[] arr) {
    int[] hash = new int[10];
    Arrays.fill(hash, 0);
    for (int i = 0; i < arr.length; ++i) hash[arr[i] % 10]++;
    for (int i = 0; i < arr.length; ++i) if (hash[i] != arr[i]) return false;
    return true;
  }
}
