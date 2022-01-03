import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class DotProduct {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first array elements as comma separated string");
        String[] arr1AsString = scanner.nextLine().split(",");
        System.out.println("Enter second array elements as comma separated string");
        String[] arr2AsString = scanner.nextLine().split(",");
        final List<Integer> arr1 = Arrays.stream(arr1AsString).map(Integer::parseInt).collect(Collectors.toList());
        final List<Integer> arr2 = Arrays.stream(arr2AsString).map(Integer::parseInt).collect(Collectors.toList());
        int sum = 0;
        for (int i = 0; i < arr1.size(); i++) {
            sum = sum + arr1.get(i) * arr2.get(i);
        }
        System.out.printf("Dot product: %s", sum);
    }
}
