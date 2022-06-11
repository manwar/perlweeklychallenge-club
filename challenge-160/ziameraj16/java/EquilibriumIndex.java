import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class EquilibriumIndex {

    public static void main(String... args) {
        System.out.println("Enter comma separated elements of the list");
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        boolean found = false;
        List<Integer> list = Arrays.stream(line.split(",")).map(Integer::valueOf).collect(Collectors.toList());
        for (int i = 1; i < list.size() - 1; i++) {
            int leftSum = sum(list.subList(0, i));
            int rightSum = sum(list.subList(i + 1, list.size()));
            if (leftSum == rightSum) {
                System.out.println(i);
                found = true;
                break;
            }
        }
        if (!found) {
            System.out.println("-1 as no Equilibrium Index found");
        }
    }

    private static int sum(List<Integer> subList) {
        return subList.stream().reduce(0, Integer::sum);
    }
}
