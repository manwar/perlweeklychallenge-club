import java.util.Scanner;

public class SumOfSquares {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number");
        int number = scanner.nextInt();
        System.out.println("Output: " + sumOfSquares(number));
    }

    public static int sumOfSquares(int n) {
        String str = String.valueOf(n);
        int i = 0;
        int sumOfSquares = 0;
        while (i < str.length()) {
            int numericValue = Character.getNumericValue(str.charAt(i));
            sumOfSquares += numericValue * numericValue;
            i++;
        }
        return isPerfectSquare(sumOfSquares) ? 1 : 0;
    }

    private static boolean isPerfectSquare(int n) {
        double sqrt = Math.sqrt(Integer.valueOf(n).doubleValue());
        return (sqrt - Math.floor(sqrt)) == 0;
    }
}
