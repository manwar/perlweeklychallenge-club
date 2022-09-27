import java.text.ParseException;
import java.util.Scanner;

public class SequenceNumber {

    public static void main(String[] args) throws ParseException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated strings");
        String[] values = scanner.nextLine().split(",");
        int number = 0;
        for (String str : values) {
            System.out.print(String.format("%02d%s",number, str.substring(2)));
            if (number < values.length - 1) {
                System.out.print(",");
            }
            number++;
        }
    }
}
