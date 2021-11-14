import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class OddNumber {

    public static void main(String[] args) {
        System.out.println("Input comma separated values");
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        List<Integer> list = Arrays.stream(line.split(",")).map(Integer::new).collect(Collectors.toList());
        System.out.println(oddNumber(list));
    }

    private static int oddNumber(List<Integer> list) {
        Collections.sort(list);
        int i;
        for (i = 0; i < list.size() - 1; i += 2) {
            if (!list.get(i).equals(list.get(i + 1))) {
                return list.get(i);
            }
        }
        if (list.size() > i) {
            return list.get(i);
        }
        return -1;
    }
}

