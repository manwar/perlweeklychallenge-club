import java.util.*;

public class FunSort {

    public static void main(String[] args) {
        System.out.println("Enter comma separated values of first array");
        List<Integer> list = Arrays.stream(new Scanner(System.in).nextLine().split(",")).map(Integer::valueOf).toList();
        SortedSet<Integer> evenNumber = new TreeSet();
        SortedSet<Integer> oddNumber = new TreeSet();
        for (int i : list) {
            if (i%2 == 0) {
                evenNumber.add(i);
            } else {
                oddNumber.add(i);
            }
        }
        List<Integer> sortedList = new ArrayList();
        sortedList.addAll(evenNumber);
        sortedList.addAll(oddNumber);
        System.out.println(sortedList);
    }
}
