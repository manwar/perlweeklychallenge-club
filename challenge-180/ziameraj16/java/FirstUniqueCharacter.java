import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;

public class FirstUniqueCharacter {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter a string");
        String str = scanner.nextLine();
        Map<Character, Integer> map = new TreeMap();
        for (int i = 0; i < str.length(); i++) {
            map.put(str.charAt(i), map.getOrDefault(str.charAt(i), 0) + 1);
        }
        for (int i = 0; i < str.length(); i++) {
            if (map.get(str.charAt(i)) == 1) {
                System.out.println(i);
                break;
            }
        }
        System.out.println("No unique character found");
    }
}
