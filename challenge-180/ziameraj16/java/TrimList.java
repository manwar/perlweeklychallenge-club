import java.util.*;
import java.util.stream.Collectors;

public class TrimList {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated numbers");
        String numbers = scanner.nextLine();
        System.out.println("Enter number");
        int  i = scanner.nextInt();
        List<Integer> list = Arrays.stream(numbers.split(",")).map(Integer::valueOf).collect(Collectors.toList());
        List<Integer> newList = new ArrayList();
        for (int num : list) {
            if (num > i) {
                newList.add(num);
            }
        }
        System.out.println(newList);
    }
}
