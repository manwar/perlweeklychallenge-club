// Use streams to calculate the count of distinct elements in an array and
// filter out just the first one above the cutoff.

// I'm particularly proud of this one.

import java.util.*;
import java.util.stream.*;
import java.util.function.Function;

class ch1 {
    private static void task1(int[] a) {
        int cutoff = (int)Math.floor(a.length / 2.0);
        int over_cutoff =
            Arrays.stream(a).boxed()
            .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()))
            .entrySet().stream()
            .filter(entry -> entry.getValue() > cutoff)
            .findFirst().map(entry -> entry.getKey()).orElse(-1);
        System.out.println(over_cutoff);
    }

    public static void main(String[] args) {
        task1(new int[] {1, 2, 2, 3, 2, 4, 2});
        task1(new int[] {1, 3, 1, 2, 4, 5});
    }
}
