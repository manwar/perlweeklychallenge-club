import java.util.Scanner;

public class CapitalDetection {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter word");
        String word = scanner.nextLine();
        if (word.toUpperCase().equals(word)) {
            System.out.println("Output: 1");
        } else if (word.toLowerCase().equals(word)) {
            System.out.println("Output: 1");
        } else if (Character.isUpperCase(word.charAt(0)) && word.substring(1).toLowerCase().equals(word.substring(1))) {
            System.out.println("Output: 1");
        } else {
            System.out.println("Output: 0");
        }
    }
}
