import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class MaskCode {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated list");
        String[] arr = scanner.nextLine().split(",");
        List<String> list = new ArrayList(arr.length);
        for (String str : arr) {
            int count = 0;
            for (int i = 0; i < str.length(); i++) {
                if (count < 4) {
                    char c = str.charAt(i);
                    if (Character.isLetterOrDigit(c)) {
                        str = str.replaceFirst(String.valueOf(c), "x");
                        count++;
                    }
                }
            }
            list.add(str);
        }
        System.out.println(list);
    }
}
