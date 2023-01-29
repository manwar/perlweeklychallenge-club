import java.util.*;
import java.util.stream.Collectors;

public class MissingNumbers {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated values");
        List<Integer> list = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).collect(Collectors.toList());
        List<Integer> missingNumbers = new ArrayList(list.size());
        for (int i = 0; i <= list.size(); i++) {
            if (!list.contains(i)) {
                missingNumbers.add(i);
            }
        }
        System.out.println(missingNumbers);
    }
}
