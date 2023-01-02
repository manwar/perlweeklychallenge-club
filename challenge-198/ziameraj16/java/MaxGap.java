import java.util.*;
import java.util.stream.Collectors;

public class MaxGap {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated values");
        List<Integer> list = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).collect(Collectors.toList());
        if (list.size() < 2) {
            System.out.println(0);
        } else {
            Collections.sort(list);
            int maxGap = 0;
            List<Integer> newList = new ArrayList();
            for (int i = 0; i < list.size() - 1; i++) {
                final Integer second = list.get(i + 1);
                final Integer first = list.get(i);
                if (second - first > maxGap) {
                    newList.clear();
                    maxGap = second - first;
                    newList.add(first);
                    newList.add(second);
                } else if (second - first == maxGap) {
                    newList.add(first);
                    newList.add(second);
                }
            }
            for (int i = 0; i < newList.size(); i+=2) {
                System.out.println("(" + newList.get(i) + "," + newList.get(i + 1) + ")");
            }
        }
    }
}
