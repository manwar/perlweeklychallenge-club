import java.util.Scanner;

public class CountNumbers {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number");
        System.out.println(countNumbers(scanner.nextInt()));
    }

    private static int countNumbers(int number) {
        int count = 0;
        for (int i = 1; i <= number; i++) {
            if (!Integer.valueOf(i).toString().contains("1")) {
                count++;
            }
        }
        return count;
    }
}
