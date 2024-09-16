import java.util.Arrays;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(unique_number(new int[]{3, 3, 1}));
    System.out.println(unique_number(new int[]{3, 2, 4, 2, 4}));
    System.out.println(unique_number(new int[]{1}));
    System.out.println(unique_number(new int[]{4, 3, 1, 1, 1, 4}));
  }

  private static int unique_number(int[] arr) {
    int[] hash = new int[10];
    Arrays.fill(hash, 0);
    for (int i = 0; i < arr.length; ++i) hash[arr[i] % 10]++;
    for (int i = 0; i < hash.length; ++i) if (hash[i] == 1) return i;
    return -1;
  }
}
