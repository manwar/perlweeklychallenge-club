import java.util.Scanner;

public class PrimeCount {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter a number");
        final int i = Integer.parseInt(scanner.nextLine());
        int numberOfPrimes = 1;
        if (i == 1) {
            System.out.println(0);
        } else if (i == 2) {
            System.out.println(1);
        } else {
            for (int j = 3 ; j <= i; j++) {
                if (isPrime(j)) {
                    numberOfPrimes++;
                }
            }
            System.out.println(numberOfPrimes);
        }
    }

    private static boolean isPrime(int num) {
        if (num % 2 == 0) {
            return false;
        }
        int i = 3;
        while (i < num / 2) {
            if (num % i == 0) {
                return false;
            }
            i = i + 2;
        }
        return true;
    }
}
