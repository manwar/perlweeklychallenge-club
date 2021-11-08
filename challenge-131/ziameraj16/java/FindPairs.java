import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class FindPairs {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Input delimiter pair string");
        String delimiterPair = scanner.nextLine();
        System.out.println("Enter search string");
        String searchString = scanner.nextLine();
        findPair(delimiterPair, searchString).forEach(System.out::println);
    }

    private static List<String> findPair(String delimiter, String searchString) {
        List<Character> openingDelimiters = new ArrayList(delimiter.length()/2 + 1);
        List<Character> closingDelimiters = new ArrayList(delimiter.length()/2 + 1);
        for (int i = 0; i < delimiter.length(); i++) {
            if (i % 2 == 0) {
                openingDelimiters.add(delimiter.charAt(i));
            } else {
                closingDelimiters.add(delimiter.charAt(i));
            }
        }

        StringBuilder opening = new StringBuilder();
        StringBuilder closing = new StringBuilder();
        for (int i = 0; i < searchString.length(); i++) {
            final char c = searchString.charAt(i);
            if (openingDelimiters.contains(c)) {
                opening.append(c);
            }
            if (closingDelimiters.contains(c)) {
                closing.append(c);
            }
        }
        return List.of(opening.toString(), closing.toString());
    }
}
