import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class MaximumGap {

    public static void main(String[] args) {
        System.out.println("Enter comma separated values");
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();
        String[] arr = input.split(",");
        List<Integer> list = Arrays.stream(arr).mapToInt(Integer::valueOf).boxed().collect(Collectors.toList());
        System.out.println(findMaxGap(list));
    }

    private static int findMaxGap(List<Integer> list) {
        if (list.size() == 1) {
            return 0;
        }
        Collections.sort(list);
        int maxDiff = Integer.MIN_VALUE;
        int i = 0;
        while (i < list.size() -1) {
            final int diff = Math.abs(list.get(i + 1) - list.get(i));
            if (diff > maxDiff) {
                maxDiff = diff;
            }
            i++;
        }
        return maxDiff;
    }
}
