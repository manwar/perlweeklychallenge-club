import java.util.*;
import java.util.stream.Collectors;

public class JortSort {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated list");
        List list = Arrays.stream(scanner.nextLine().split(",")).map(Integer::parseInt).collect(Collectors.toList());
        System.out.println(isSorted(list));
    }

    private static int isSorted(List<Integer> list) {
        List temp = new ArrayList(list);
        Collections.sort(temp);
        return temp.equals(list) ? 1 : 0;
    }
}

