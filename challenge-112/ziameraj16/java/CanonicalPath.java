import java.util.Scanner;

public class CanonicalPath {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter a string");
        String input = scanner.next();
        System.out.println(getCanonicalPath(input));
    }

    public static String getCanonicalPath(String input) {
        input = input.replaceAll("//", "/");
        if ('/' == (input.charAt(input.length() - 1))) {
            input = input.substring(0, input.length() - 1);
        }
        while (input.contains("/..")) {
            int index = input.indexOf("/..");
            input = input.replace("/" + input.charAt(index - 1) + "/..", "");
        }
        return input;
    }
}
