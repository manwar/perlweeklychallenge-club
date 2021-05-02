import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Pattern;

public class ValidPhoneNumbers {

    public static void main(String[] args) throws IOException {

        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter full file path");
        String filePath = scanner.next();
        List<String> allLines = Files.readAllLines(Paths.get(filePath));
        for (String value : allLines) {
            if (Pattern.compile("^[0-9]{4}\\s[0-9]{10}$").matcher(value.trim()).matches()
                || Pattern.compile("^\\+[0-9]{2}\\s[0-9]{10}$").matcher(value.trim()).matches()
                || Pattern.compile("^\\([0-9]{2}\\)\\s[0-9]{10}$").matcher(value.trim()).matches()) {
                System.out.println(value);
            }
        }
    }

}
