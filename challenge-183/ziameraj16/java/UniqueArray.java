import java.util.*;
import java.util.stream.Collectors;

public class UniqueArray {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number of arrays");
        int val = Integer.parseInt(scanner.nextLine());
        Set<List<Integer>> set = new HashSet<>(val);
        for (int i = 0; i < val; i++) {
            System.out.println("Enter comma separated elements of array");
            set.add(Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).collect(Collectors.toList()));
        }
        System.out.println(set);
    }
}
