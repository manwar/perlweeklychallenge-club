public class Ch1 {
  public static void main(String[] args) {
    int[] nums = {38, 7, 999, 1999999999, 101010};
    for(int n : nums) {
      int[] res = digital_root(n);
      System.out.printf("Persistence  = %d\nDigital Root = %d\n",
			res[0], res[1]);
    }
  }

  private static int[] digital_root(int n) {
    int pers = 0, curr = n;

    while(curr > 9) {
      String str_num = Integer.toString(curr);
      int sum = 0;
      for(int i = 0; i < str_num.length(); ++i) {
	char c = str_num.charAt(i);
	int d = Character.getNumericValue(c);
	sum += d;
      }
      curr = sum;
      pers++;
    }
    return new int[]{pers,curr};
  }
}

