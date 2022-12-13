import java.util.*;
import java.util.stream.Collectors;

public class MostFrequentEven {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated values");
        List<Integer> list = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).collect(Collectors.toList());
        Map<Integer, Integer> map = new HashMap();
        for (int i : list) {
            if (i % 2 == 0) {
                if (map.containsKey(i)) {
                    map.put(i, map.get(i) + 1);
                } else {
                    map.put(i, 1);
                }
            }
        }
        if (map.isEmpty()) {
            System.out.println("Output: -1");
        } else {
            List<Map.Entry<Integer, Integer>> sorted =
                    map.entrySet().stream()
                            .sorted(Collections.reverseOrder(Map.Entry.comparingByValue()))
                            .sorted(Map.Entry.comparingByKey()).collect(Collectors.toList());
            System.out.println(sorted.get(0).getKey());
        }

    }
}
