import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

public class ReverseWords {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the string");
        final String str = scanner.nextLine();
        System.out.println("Reversed string is: " + reverseWords(str));

    }

    public static String reverseWords(String str) {
        String[] strWithSingleSpace = str.trim().replaceAll(" +", " ").split(" ");
        final List<String> list = Arrays.asList(strWithSingleSpace);
        Collections.reverse(list);
        return String.join(" ", list);
    }
}
