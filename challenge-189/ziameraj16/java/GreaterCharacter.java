import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class GreaterCharacter {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated chars");
        List<Character> list = Arrays.stream(scanner.nextLine().split(",")).map(s -> s.charAt(0)).collect(Collectors.toList());
        System.out.println("Enter value of target");
        char target = scanner.next().charAt(0);
        int diff = 26;
        for (Character c : list) {
            if (c - target > 0 && c - target < diff) {
                diff = c - target;
            }
        }
        if (diff == 26) {
            System.out.println("Output: " + target);
        } else {
            System.out.println("Output: " + (char) (target + diff));
        }
    }
}
