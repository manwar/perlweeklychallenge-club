import java.util.Scanner;

public class CaesarCipher {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter a string");
        String str = scanner.nextLine();
        System.out.println("Enter offset");
        int offset = scanner.nextInt();
        System.out.println("Output: "+ caesarCipher(str, offset));
    }

    private static String caesarCipher(String input, int offset) {
        StringBuilder sb = new StringBuilder();
        for (char character : input.toCharArray()) {
            if (character == ' ') {
                sb.append(character);
                continue;
            }
            int originalPosition = character - 'A';
            int newPosition = (originalPosition - offset) % 26;
            char newCharacter = (char) ('A' + newPosition);
            if (newPosition < 0) {
                newCharacter = (char) ('Z' + (newPosition + 1));
            }

            sb.append(newCharacter);
        }
        return sb.toString();
    }
}

