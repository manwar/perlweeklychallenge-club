import java.util.Scanner;

public class HigherIntegerSetBits {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number");
        int number = scanner.nextInt();
        System.out.println(findNextNumberWithSameOnes(number));

    }

    public static int findNextNumberWithSameOnes(int n) {
        long value = Integer.toBinaryString(n).chars().filter(ch -> ch == '1').count();
        while(true) {
            if (value == Integer.toBinaryString(++n).chars().filter(ch -> ch == '1').count()) {
                return n;
            }
        }
    }
}
