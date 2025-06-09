import java.util.Arrays;
import java.util.Stack;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(Arrays.toString(final_price(new int[]{8, 4, 6, 2, 3})));
    System.out.println(Arrays.toString(final_price(new int[]{1, 2, 3, 4, 5})));
    System.out.println(Arrays.toString(final_price(new int[]{7, 1, 1, 5})));
  }

  private static int[] final_price(int[] arr) {
    Stack<Integer> stack = new Stack<>();
    for (int i = 0; i < arr.length; ++i) {
      while (!stack.isEmpty() && arr[stack.peek()] >= arr[i])
        arr[stack.pop()] -= arr[i];
      stack.push(i);
    }
    return arr;
  }
}

