import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(Arrays.toString(decode_xor(new int[]{1, 2, 3}, 1)));
    System.out.println(Arrays.toString(decode_xor(new int[]{6, 2, 7, 3}, 4)));
  }

  private static int[] decode_xor(int[] arr, int first) {
    int[] res = new int[arr.length + 1];
    res[0] = first;
    for (int i = 0; i < arr.length; ++i)
      res[i + 1] = res[i] ^ arr[i];
    return res;
  }
}
