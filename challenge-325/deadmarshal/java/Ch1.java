public class Ch1 {
  public static void main(String[] args) {
    System.out.println(consecutive_one(new int[]{0, 1, 1, 0, 1, 1, 1}));
    System.out.println(consecutive_one(new int[]{0, 0, 0, 0}));
    System.out.println(consecutive_one(new int[]{1, 0, 1, 0, 1, 1}));
  }

  private static int consecutive_one(int[] arr) {
    int count = 0, res = 0;
    for (int e : arr) {
      if (e == 1) count++;
      else {
        res = Math.max(res, count);
        count = 0;
      }
    }
    return Math.max(count, res);
  }
}

