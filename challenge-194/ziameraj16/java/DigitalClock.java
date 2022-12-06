import java.util.Scanner;

public class DigitalClock {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter time in format hh:mm");
        String time = scanner.nextLine();
        char first = time.charAt(0);
        char second = time.charAt(1);
        char third = time.charAt(3);
        char fourth = time.charAt(4);
        if (first == '?') {
            if (Character.getNumericValue(second) > 3) {
                System.out.println("Output: 1");
            } else {
                System.out.println("Output: 2");
            }
        } else if (second == '?') {
            if (Character.getNumericValue(first) == 2) {
                System.out.println("Output: 3");
            } else {
                System.out.println("Output: 9");
            }
        } else if (third == '?') {
            System.out.println("Output: 5");
        } else if (fourth == '?') {
            System.out.println("Output: 9");
        } else {
            System.out.println("Invalid time");
        }
    }
}
