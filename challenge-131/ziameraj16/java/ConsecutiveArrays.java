import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class ConsecutiveArrays {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        System.out.println(getConsecutiveArrays(Arrays.stream(line.split(","))
                .map(Integer::parseInt)
                .collect(Collectors.toList())));
    }

    private static List<List<Integer>> getConsecutiveArrays(List<Integer> inputList) {
        List<List<Integer>> consecutiveList = new ArrayList();
        List<Integer> list = new ArrayList();
        list.add(inputList.get(0));
        for(int i = 1; i < inputList.size(); i++) {
            if (inputList.get(i) == inputList.get(i - 1) + 1) {
                list.add(inputList.get(i));
            } else {
                consecutiveList.add(list);
                list = new ArrayList();
                list.add(inputList.get(i));
            }
            if (i == inputList.size() - 1) {
                consecutiveList.add(list);
            }
        }
        return consecutiveList;
    }
}
