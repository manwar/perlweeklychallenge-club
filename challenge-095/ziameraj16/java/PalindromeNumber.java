import java.util.Scanner;

public class PalindromeNumber {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number to check if it is a palindrome");
        final String input = scanner.next();
        System.out.println(isNumberPalindrome(input));
    }

    public static int isNumberPalindrome(String input) {
        for (int i = 0; i <= input.length() / 2; i++) {
            if (input.charAt(i) != input.charAt(input.length() - 1 - i)) {
                return 0;
            }
        }
        return 1;
    }


}
