import java.util.Scanner;

public class DivisiblePair {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter value of x");
        int x = scanner.nextInt();
        System.out.println("Enter value of y");
        int y = scanner.nextInt();
        System.out.printf("x = %s, y = %s", x, y);
        int count = 0;
        while (x > 0 && y > 0) {
            if (x >= y) {
                x = x - y;
            } else {
                y = y - x;
            }
            count++;
        }
        System.out.println();
        System.out.println("Output: " + count);
    }
}
