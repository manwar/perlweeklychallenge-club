import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class MinimumIndexSum {

    public static void main(String[] args) {
        System.out.println("Enter comma separated values of first array");
        List<String> list1 = Arrays.stream(new Scanner(System.in).nextLine().split(",")).toList();
        System.out.println("Enter comma separated values of second array");
        List<String> list2 = Arrays.stream(new Scanner(System.in).nextLine().split(",")).toList();
        int minIndex = Integer.MAX_VALUE;
        List<String> values = new ArrayList();
        for (String s : list1) {
            if (list2.contains(s) && (list1.indexOf(s) + list2.indexOf(s)) <= minIndex) {
                minIndex = list1.indexOf(s) + list2.indexOf(s);
                values.add(s);
            }
        }
        System.out.println(values);
    }
}

