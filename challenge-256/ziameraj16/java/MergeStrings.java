import java.util.*;

public class MergeStrings {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first string");
        String first = scanner.nextLine();
        System.out.println("Enter second string");
        String second = scanner.nextLine();
        StringBuilder sb = new StringBuilder();
        int i = 0;
        while (i < first.length() && i < second.length()) {
            sb.append(first.charAt(i));
            sb.append(second.charAt(i));
            i++;
        }
        if (first.length() > second.length()) {
            sb.append(first.substring(i));
        } else if (second.length() > first.length()) {
            sb.append(second.substring(i));
        }
        System.out.println(sb);
    }
}
