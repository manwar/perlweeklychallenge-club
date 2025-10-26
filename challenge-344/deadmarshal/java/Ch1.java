import java.util.List;
import java.util.LinkedList;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(array_form_compute(new int[]{1,2,3,4},12));
    System.out.println(array_form_compute(new int[]{2,7,4},181));
    System.out.println(array_form_compute(new int[]{9,9,9},1));
    System.out.println(array_form_compute(new int[]{1,0,0,0,0},9999));
    System.out.println(array_form_compute(new int[]{0},1000));
  }

  private static List<Integer> array_form_compute(int[] arr,int k) {
    int i = arr.length-1,carry = 0;
    List<Integer> res = new LinkedList<>();
    while(i >= 0 || k > 0 || carry > 0) {
      carry += (i < 0 ? 0 : arr[i--]) + k % 10;
      res.addFirst(carry % 10);
      carry /= 10;
      k /= 10;
    }
    return res;
  }
}

