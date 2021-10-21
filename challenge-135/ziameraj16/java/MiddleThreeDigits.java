import java.util.Scanner;

public class MiddleThreeDigits {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the Number");
        int num = scanner.nextInt();
        System.out.println(middleThreeDigits(num));
    }

    private static String middleThreeDigits(int num) {
        String numberAsString = Integer.toString(Math.abs(num));
        final int length = numberAsString.length();
        if (length < 3) {
            return "too short";
        } else if (length % 2 == 0) {
            return "even number of digits";
        }
        return numberAsString.substring(length/2 - 1, length/2 + 2);
    }
}
