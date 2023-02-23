import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Scanner;

public class ThirdHighest {

    public static void main(String[] args) {
        System.out.println("Enter comma separated values");
        List<Integer> list = Arrays.stream(new Scanner(System.in).nextLine().split(","))
                .map(Integer::valueOf).sorted(Comparator.reverseOrder()).distinct().toList();
        System.out.println(list.size() < 3 ? list.get(0) : list.get(2));
    }
}
