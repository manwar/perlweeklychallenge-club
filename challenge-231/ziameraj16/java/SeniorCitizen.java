import java.util.*;

public class SeniorCitizen {

    public static void main(String[] args) {
        System.out.println(Arrays.stream(new Scanner(System.in).nextLine().split(","))
                .toList().stream().map(value -> Integer.valueOf(value.substring(12, 14))).filter(i -> i >= 60).count());
    }
}
