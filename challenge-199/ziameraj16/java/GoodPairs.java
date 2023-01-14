import java.util.*;
import java.util.stream.Collectors;

public class GoodPairs {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated values");
        List<Integer> list = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).collect(Collectors.toList());
        int count = 0;
        for (int i = 1; i < list.size(); i++) {
            for (int j = 0; j < i; j++) {
                if (list.get(i) == list.get(j)) {
                    count++;
                }
            }
        }
        System.out.println(count);
    }
}
