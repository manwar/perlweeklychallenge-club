import java.util.Scanner;

public class NextPalindromeNumber {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number");
        int number = scanner.nextInt();
        System.out.println(findNextPalindromeNumber(number));
    }

    public static int findNextPalindromeNumber(int n) {
        while (true) {
            if (isPalindrome(++n)) {
                return n;
            }
        }
    }

    private static boolean isPalindrome(int number) {
        String numberAsString = String.valueOf(number);
        for (int i = 0; i < numberAsString.length() / 2; i++) {
            if (numberAsString.charAt(i) != numberAsString.charAt(numberAsString.length() - i - 1)) {
                return false;
            }
        }
        return true;

    }
}
