import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class TwiceLargest {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter list of numbers");
        final List<Integer> numbers = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).sorted().collect(Collectors.toList());
        int biggest = numbers.get(numbers.size() - 1);
        int check = 1;
        for (int i = 0; i < numbers.size() - 1; i++) {
            if (!(biggest > 2 * numbers.get(i))) {
                check = -1;
                break;
            }
        }
        System.out.println("Output: " + check);
    }
}
