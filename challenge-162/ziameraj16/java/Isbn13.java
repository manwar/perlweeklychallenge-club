import java.util.Scanner;

import static java.lang.Character.getNumericValue;

public class Isbn13 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first 12 digit string of ISBN-13");
        String isbn12 = scanner.nextLine();
        System.out.println(10 - ((getNumericValue(isbn12.charAt(0)) + getNumericValue(isbn12.charAt(2))
                + getNumericValue(isbn12.charAt(6)) + getNumericValue(isbn12.charAt(8))
                + getNumericValue(isbn12.charAt(11)) + getNumericValue(isbn12.charAt(13))
                + 3 * (getNumericValue(isbn12.charAt(1)) + getNumericValue(isbn12.charAt(4))
                + getNumericValue(isbn12.charAt(7)) + getNumericValue(isbn12.charAt(10))
                + getNumericValue(isbn12.charAt(12)) + getNumericValue(isbn12.charAt(14)))) % 10));
    }
}
