import java.util.Scanner;

public class NimGame {

    public static void main(String[] args) {
        System.out.println("Let's play NIM");
        Scanner scanner = new Scanner(System.in);
        int n = 12;
        while (true) {
            if (n <= 3) {
                System.out.println("CONGRATULATIONS!!! - Player 1. You won the game");
                System.exit(1);
            }
            System.out.println("Player 1 - How many tokens?");
            int tokens = scanner.nextInt();
            n = n - tokens;
            if (n <= 3) {
                System.out.println("CONGRATULATIONS!!! - Player 2. You won the game");
                System.exit(1);
            }
            System.out.println("Player 2 - How many tokens?");
            tokens = scanner.nextInt();
            n = n - tokens;
        }
    }
}

