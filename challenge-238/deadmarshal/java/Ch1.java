public class Ch1 {
  public static void main(String[] args) {
    int[] arr1 = {1,2,3,4,5};
    int[] arr2 = {1,1,1,1,1};
    int[] arr3 = {0,-1,1,2};
    running_sum(arr1);
    running_sum(arr2);
    running_sum(arr3);  
  }

  private static void running_sum(int[] arr) {
    int sum = 0;
    for(var e : arr){
      sum += e;
      System.out.printf("%d ",sum);
    }
    System.out.println();
  }
}

