public class Ch2 {
  public static void main(String[] args) {
    System.out.println(sum_difference(new int[]{1, 23, 4, 5}));
    System.out.println(sum_difference(new int[]{1, 2, 3, 4, 5}));
    System.out.println(sum_difference(new int[]{1, 2, 34}));
  }

  private static int sum_difference(int[] arr) {
    int sum1 = 0, sum2 = 0;
    for (int n : arr) {
      sum1 += n;
      sum2 += sum_digits(n);
    }
    return Math.abs(sum1 - sum2);
  }

  private static int sum_digits(int n) {
    int sum = 0;
    while (n != 0) {
      sum += n % 10;
      n /= 10;
    }
    return sum;
  }
}