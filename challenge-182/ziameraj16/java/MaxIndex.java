import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class MaxIndex {

    public static void main(String[] args) throws IOException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated list of numbers");
        final List<Integer> list = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).collect(Collectors.toList());
        int maxAt = 0;
        for (int i = 0; i < list.size(); i++) {
            maxAt = list.get(i) > list.get(maxAt) ? i : maxAt;
        }
        System.out.println(maxAt);
    }
}
