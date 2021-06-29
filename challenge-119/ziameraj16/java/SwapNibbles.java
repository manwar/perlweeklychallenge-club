import java.util.Scanner;

public class SwapNibbles {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number");
        int number = scanner.nextInt();
        System.out.println(swapNibbles(number));
    }

    public static int swapNibbles(int number) {
        final String binaryString = Integer.toBinaryString(number);
        String formattedString = String.format("%0"+ (8 - binaryString.length() ) + "d%s", 0 , binaryString);
        StringBuilder sb = new StringBuilder(formattedString);
        for (int i = 0; i < 4; i++) {
            char temp = formattedString.charAt(i);
            sb.replace(i, i + 1, String.valueOf(formattedString.charAt(i + 4)));
            sb.replace(i + 4, i + 5, String.valueOf(temp));
        }
        return Integer.parseInt(sb.toString(), 2);
    }
}
