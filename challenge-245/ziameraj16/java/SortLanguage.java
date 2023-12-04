import java.util.*;

public class SortLanguage {

    public static void main(String[] args) {
        final Scanner scanner = new Scanner(System.in);
        System.out.println("Enter comma separated languages");
        List<String> languages = Arrays.stream(scanner.nextLine().split(",")).toList();
        System.out.println("Enter comma separated popularity value");
        List<Integer> popularityList = Arrays.stream(scanner.nextLine().split(",")).map(Integer::valueOf).toList();
        List<String> output = new ArrayList<>(popularityList.size());
        for (int i = 1; i <= popularityList.size(); i++) {
            output.add(languages.get(popularityList.indexOf(i)));
        }
        System.out.println(output);
    }
}
