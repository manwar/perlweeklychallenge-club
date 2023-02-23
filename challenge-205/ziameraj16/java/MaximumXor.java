import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class MaximumXor {

    public static void main(String[] args) {
        System.out.println("Enter comma separated values");
        List<Integer> list = Arrays.stream(new Scanner(System.in).nextLine().split(","))
                .map(Integer::valueOf).toList();
        int maxXor = -1;
        for (int i = 0; i < list.size() - 1; i++) {
            for (int j = i + 1; j < list.size(); j++) {
                final int xorValue = list.get(i).intValue() ^ list.get(j).intValue();
                if (xorValue > maxXor) {
                    maxXor = xorValue;
                }
            }
        }
        System.out.println(maxXor);
    }
}
