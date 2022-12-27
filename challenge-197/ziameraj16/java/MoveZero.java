import java.util.*;
import java.util.stream.Collectors;

public class MoveZero {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated values");
        List<Integer> list = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).collect(Collectors.toList());
        List<Integer> nonZeros = new ArrayList();
        List<Integer> zeros = new ArrayList();
        list.stream().forEach(integer -> {
            if (integer == 0) {
                zeros.add(0);
            } else {
                nonZeros.add(integer);
            }
        });
        nonZeros.addAll(zeros);
        System.out.println(nonZeros);
    }
}
