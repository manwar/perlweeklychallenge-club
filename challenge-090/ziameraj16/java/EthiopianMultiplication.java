
import java.util.Scanner;

public class EthiopianMultiplication {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first number");
        final int first = scanner.nextInt();
        System.out.println("Enter second number");
        final int second = scanner.nextInt();
        System.out.println("Result using Ethiopian Multiplication: " + multiply(first, second));
    }

    public static int multiply(int first, int second) {
        int sum = 0;
        for (int i = first; i >= 1; i = i/2) {
            if (i % 2 != 0) {
                sum += second;
            }
            second = second * 2;
        }
        return sum;
    }
}
