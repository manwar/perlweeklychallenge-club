import java.util.Scanner;

public class ClimbStairs {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter total number of stairs");
        int stepsToClimb = scanner.nextInt();
        System.out.println("Output: " + numberOfWays(stepsToClimb + 1));
    }

    public static int numberOfWays(int n) {
        if (n <= 1) {
            return n;
        }
        return numberOfWays(n -1) + numberOfWays(n - 2);
    }
}
