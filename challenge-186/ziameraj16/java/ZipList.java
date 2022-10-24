import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class ZipList {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first comma separated list");
        String[] arr1 = scanner.nextLine().split(",");
        System.out.println("Enter second comma separated list");
        String[] arr2 = scanner.nextLine().split(",");
        List<String> mergedList1 = new ArrayList<>(arr1.length*2);
        List<String> mergedList2 = new ArrayList<>(arr1.length*2);
        for (int i = 0; i < arr1.length; i++) {
            mergedList1.add(arr1[i]);
            mergedList1.add(arr2[i]);
            mergedList2.add(arr2[i]);
            mergedList2.add(arr1[i]);
        }
        System.out.println("zip(@a, @b)" + mergedList1);
        System.out.print("zip(@b, @a)" + mergedList2);
    }
}
