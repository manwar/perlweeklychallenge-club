import java.util.*;
import java.util.stream.Collectors;

public class LargestMultiple {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separate numbers");
        final String input = scanner.nextLine();
        final List<Integer> list = Arrays.stream(input.split(",")).map(Integer::valueOf).collect(Collectors.toList());
        System.out.print("Output: ");
        getLargestMultiple(list).stream().forEach(System.out::print);
        System.out.println();
    }

    public static List<Integer> getLargestMultiple(List<Integer> list) {
        final List<Integer> sortedList = list.stream().sorted(Comparator.reverseOrder()).collect(Collectors.toList());
        if (sortedList.get(sortedList.size() - 1) % 2 == 0) {
            return sortedList;
        } else {
            int i = list.size() - 2;
            while (true) {
                if (sortedList.get(i) % 2 == 0) {
                    List<Integer> newList = new ArrayList<>(list.size());
                    for (int j = 0; j <= i - 1; j++) {
                        newList.add(sortedList.get(j));
                    }
                    for (int j = i + 1; j < list.size(); j++) {
                        newList.add(sortedList.get(j));
                    }
                    newList.add(sortedList.get(i));
                    return newList;
                }
                i--;
            }
        }
    }
}

