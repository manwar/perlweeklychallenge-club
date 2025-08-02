public class Ch1 {
  public static void main(String[] args) {
    System.out.println(complete_day(new int[]{12, 12, 30, 24, 24}));
    System.out.println(complete_day(new int[]{72, 48, 24, 55}));
    System.out.println(complete_day(new int[]{12, 18, 24}));
  }

  private static int complete_day(int[] arr) {
    int count = 0;
    for (int i = 0; i < arr.length - 1; ++i)
      for (int j = i + 1; j < arr.length; ++j)
        if ((arr[i] + arr[j]) % 24 == 0) count++;
    return count;
  }
}
