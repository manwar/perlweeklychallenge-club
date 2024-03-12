import java.util.*;

public class UniqueOccurrences {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separate numbers");
        final List<Integer> original = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).toList();
        Set<Integer> set = new HashSet(original);
        Set<Integer> frequency = new HashSet<>();
        for (int value : set) {
            if(!frequency.add(Collections.frequency(original, value))) {
                System.out.println("0");
                System.exit(1);
            }
        }
        System.out.println("1");
    }
}
