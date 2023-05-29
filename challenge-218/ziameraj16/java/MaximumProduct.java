import java.util.*;

public class MaximumProduct {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Integer> values = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).toList();
        int maxProduct = 0;
        String str = null;
        int size = values.size();
        for (int x = 0; x < size - 2; x++) {
            for (int y = x + 1; y < size - 1; y++) {
                for (int z = y + 1; z < size; z++) {
                    Integer first = values.get(x);
                    Integer second = values.get(y);
                    Integer third = values.get(z);
                    if (first * second * third > maxProduct) {
                        maxProduct = first * second * third;
                        str = String.format("%s x %s x %s => %s", first, second, third, maxProduct);
                    }
                }
            }
        }
        System.out.println(str);
    }
}
