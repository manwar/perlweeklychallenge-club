import java.util.*;

public class SortedSquares {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println(Arrays.stream(scanner.nextLine()
                .split(","))
                .map(Integer::valueOf)
                .map(value -> value * value).sorted()
                .toList());
    }
}

