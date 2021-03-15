import java.util.Arrays;
import java.util.Scanner;

public class SearchInsertPosition {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter array values as comma separated");
        String str = scanner.nextLine();
        int[] arr = Arrays.stream(str.split(",")).mapToInt(Integer::parseInt).toArray();
        System.out.println("Enter target");
        int number = scanner.nextInt();
        System.out.println("Output: " + searchInsertPosition(arr, number));
    }

    public static int searchInsertPosition(int[] arr, int number) {
        int[] newArr = new int[arr.length + 1];
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] < number) {
                continue;
            }
            if (arr[i] != number) {
                System.arraycopy(arr, 0, newArr, 0, i);
                newArr[i] = number;
                System.arraycopy(arr, i, newArr, i + 1, arr.length - i);
                System.out.println("New array: " + Arrays.toString(newArr));
            }
            return i;
        }
        System.arraycopy(arr, 0, newArr, 0, arr.length);
        newArr[arr.length] = number;
        System.out.println("New array: " + Arrays.toString(newArr));
        return arr.length;
    }
}
