import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

public class TransposeFile {

    public static void main(String[] args) throws IOException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter full file path");
        String filePath = scanner.next();
        List<String> allLines = Files.readAllLines(Paths.get(filePath));
        int columns = allLines.get(0).split(",").length;
        String[][] arr = new String[allLines.size()][columns];
        int i = 0;
        for (String data : allLines) {
            String[] value = data.split(",");
            arr[i++] = value;
        }
        for (int row = 0; row < arr[0].length; row++) {
            StringBuilder sb = new StringBuilder();
            for (String[] strings : arr) {
                sb.append(strings[row]).append(",");
            }
            sb.setLength(sb.length() - 1);
            System.out.println(sb.toString());
        }
    }
}
