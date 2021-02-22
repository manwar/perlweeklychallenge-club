import java.util.*;
import java.util.stream.Collectors;

public class TriangleSum {

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number of rows in the triangle");
        int numberOfRows = Integer.parseInt(scanner.nextLine());
        List<List<Integer>> list = new ArrayList();
        int  i = 1;
        while (i <= numberOfRows) {
            System.out.println("Enter comma separated elements of line " + i);
            List<Integer> rowElements = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).collect(Collectors.toList());
            list.add(rowElements);
            i++;
        }
        System.out.println("Output: " + triangleSum(list));
    }

    public static int triangleSum(List<List<Integer>> list) {
        int sum = 0;
        for (List<Integer> row : list) {
            sum += Collections.min(row);
        }
        return sum;
    }
}
