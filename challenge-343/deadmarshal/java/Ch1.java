public class Ch1 {
  public static void main(String[] args) {
    System.out.println(zero_friend(new int[]{4,2,-1,3,-2}));
    System.out.println(zero_friend(new int[]{-5,5,-3,3,-1,1}));
    System.out.println(zero_friend(new int[]{7,-3,0,2,-8}));
    System.out.println(zero_friend(new int[]{-2,-5,-1,-8}));
    System.out.println(zero_friend(new int[]{-2,2,-4,4,-1,1}));
  }

  private static int zero_friend(int[] arr) {
    int res = Integer.MAX_VALUE;
    for(int e : arr)
      if(Math.abs(e) < res) res = Math.abs(e);
    return res;
  }
}

