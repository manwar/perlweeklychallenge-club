import java.util.*;

public class OddOneOut {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<String> values = Arrays.stream(scanner.nextLine().split(",")).toList();
        int count = 0;
        List<String> newList = new ArrayList<>(values.size());
        for (String str : values) {
            String temp = new String(str);
            final char[] chars = str.toCharArray();
            Arrays.sort(chars);
            if (!temp.equals(new String(chars))) {
                count++;
            } else {
                newList.add(str);
            }
        }
        System.out.println(count);
        System.out.println(newList);
    }
}

