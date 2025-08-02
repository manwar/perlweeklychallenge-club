// Solution of Task 1 of The Weekly Challenge 263
// https://theweeklychallenge.org/blog/perl-weekly-challenge-263/

/*
$ java ch-1.java
[1, 2]
[]
[4]
*/

import java.util.Arrays;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        int[][] tests = {{1, 5, 3, 2, 4, 2},
                        {1, 2, 4, 3, 5},
                        {5, 3, 2, 4, 2, 1}};
        int[] values = {2, 6, 4};

        for (int c = 0; c != tests.length; c++) {
            int[] data = tests[c];
            int value = values[c];

            ArrayList<Integer> indices = solve(data, value);
            System.out.println(indices);
        }
    }

    static ArrayList<Integer> solve(int[] data, int value) {
        Arrays.sort(data);

        ArrayList<Integer> indices = new ArrayList<Integer>();
        for (int c = 0; c != data.length; c++) {
            int current = data[c];
            if (current == value) indices.add(c);
            if (current > value) break;
        }

        return indices;
    }
}
