import java.util.Scanner;

public class MacAddress {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter Mac address");
        String macAddress = scanner.nextLine();
        System.out.println(String.format("%s:%s:%s:%s:%s:%s", macAddress.substring(0, 2)
                , macAddress.substring(2, 4), macAddress.substring(5, 7), macAddress.substring(7, 9)
                , macAddress.substring(10, 12), macAddress.substring(12)));
    }
}
