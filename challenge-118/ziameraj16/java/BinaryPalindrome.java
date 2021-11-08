import java.util.Scanner;

public class BinaryPalindrome {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number");
        int number = scanner.nextInt();
        System.out.println(isPalindrome(number));
    }

    public static int isPalindrome(int number) {
        final String binaryString = Integer.toBinaryString(number);
        StringBuilder sb = new StringBuilder(binaryString);
        return sb.reverse().toString().equals(binaryString) ? 1 : 0;
    }
}

