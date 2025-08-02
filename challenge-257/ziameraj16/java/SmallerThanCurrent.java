import java.util.*;
import java.util.stream.Collectors;

public class SmallerThanCurrent {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separate numbers");
        final List<Integer> original = Arrays.stream(scanner.nextLine().split(",")).map(Integer::new).collect(Collectors.toList());
        List<Integer> sorted = new ArrayList<>(original);
        Collections.sort(sorted);
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < sorted.size(); i++) {
            if (!map.containsKey(sorted.get(i))) {
                map.put(sorted.get(i), i);
            }
        }
        List<Integer> output = new ArrayList<>();
        for (int i : original) {
            output.add(map.get(i));
        }
        System.out.println(output);
    }
}
