import java.util.Scanner;
import java.util.regex.Pattern;

public class PatternMatcher {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter regex pattern");
        String pattern = scanner.nextLine();
        System.out.println("Enter string to match");
        String str = scanner.nextLine();
        System.out.println("Output: " + patternMatch(str, pattern));
    }

    public static int patternMatch(String str, String pattern) {
        return Pattern.matches(pattern, str) ? 1 : 0;
    }
}

