import java.util.Scanner;

public class SwapOddEvenBits {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number");
        int number = scanner.nextInt();
        System.out.println(swap(number));
    }

    public static int swap(int number) {
        final String binaryString = Integer.toBinaryString(number);
        String formattedString = String.format("%0"+ (8 - binaryString.length() ) + "d%s", 0 , binaryString);
        StringBuilder sb = new StringBuilder(formattedString);
        for (int i = 0; i < 7; i += 2) {
            char temp = formattedString.charAt(i);
            sb.replace(i, i + 1, String.valueOf(formattedString.charAt(i + 1)));
            sb.replace(i + 1, i + 2, String.valueOf(temp));
        }
        return Integer.parseInt(sb.toString(), 2);
    }
}
