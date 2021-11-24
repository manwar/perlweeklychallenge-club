import java.util.Scanner;

public class AddBinary {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first number in Binary format");
        long first = Long.parseLong(scanner.next(), 2);
        System.out.println("Enter second number in Binary format");
        long second = Long.parseLong(scanner.next(), 2);
        System.out.println(Long.toBinaryString(first + second));
    }
}
