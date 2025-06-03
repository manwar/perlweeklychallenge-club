public class Ch2 {
  public static void main(String[] args) {
    System.out.println(total_xor(new int[]{1, 3}));
    System.out.println(total_xor(new int[]{5, 1, 6}));
    System.out.println(total_xor(new int[]{3, 4, 5, 6, 7, 8}));
  }

  private static int total_xor(int[] arr) {
    int n = arr.length, res = 0;
    for (int i = 0; i < 1 << n; ++i) {
      int s = 0;
      for (int j = 0; j < n; ++j) if ((i >> j & 1) == 1) s ^= arr[j];
      res += s;
    }
    return res;
  }
}

