import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class DisjointSets {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated list of numbers for that first set");
        String[] arr1 = scanner.nextLine().split(",");
        List<Integer> list1 = Arrays.stream(arr1).map(Integer::valueOf).collect(Collectors.toList());
        System.out.println("Enter comma separate list of numbers for the second set");
        String[] arr2 = scanner.nextLine().split(",");
        List<Integer> list2 = Arrays.stream(arr2).map(Integer::valueOf).collect(Collectors.toList());
        System.out.println(areDisjointSets(list1,list2));
    }

    private static int areDisjointSets(List<Integer> first, List<Integer> second) {
        return Collections.disjoint(first, second) ? 1 : 0;
    }
}
