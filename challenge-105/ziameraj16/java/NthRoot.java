import java.util.Scanner;

public class NthRoot {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter value of N");
        double N = scanner.nextDouble();
        System.out.println("Enter value of k");
        int k = scanner.nextInt();
        System.out.printf("%.2f", findNthRoot(N, k));
    }

    public static double findNthRoot(double N, int k) {
        return Math.pow(k, 1/N);
    }
}
