/*

Week 136:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-136

Task #2: Fibonacci Sequence

    You are given a positive number $n.

    Write a script to find how many different sequences you can create using Fibonacci numbers where the sum of unique numbers in each sequence are the same as the given number.

*/

import java.util.ArrayList;
import java.util.List;

public class FibonacciSequence {

    public static void main(String[] args) {
        System.out.println("Example 1: " + getFibonacciSequence(16));
        System.out.println("Example 2: " + getFibonacciSequence(9));
        System.out.println("Example 3: " + getFibonacciSequence(15));
    }

    public static int getFibonacciSequence(int sum) {
        List<Integer> fibonacci = getFibonacciSeriesUpto(sum);
        List<List<Integer>> combinations = getUniqueCombinations(fibonacci);

        int count = 0;
        for (List<Integer> c:combinations) {
            if (sumList(c) == sum) {
                count++;
            }
        }

        return count;
    }

    public static List<Integer> getFibonacciSeriesUpto(int sum) {

        List<Integer> fibonacci = new ArrayList<>();
        fibonacci.add(1);
        fibonacci.add(2);

        int size = 2;
        while (fibonacci.get(size - 1) + fibonacci.get(size - 2) <= sum) {
            fibonacci.add(fibonacci.get(size - 1) + fibonacci.get(size - 2));
            size++;
        }

        return fibonacci;
    }

    public static int sumList(List<Integer> list) {
        int sum = 0;
        for (int i: list) {
            sum += i;
        }

        return sum;
    }

    // stackoverflow
    //
    // https://stackoverflow.com/questions/5162254/all-possible-combinations-of-an-array

    public static List<List<Integer>> getUniqueCombinations(List<Integer> elements) {
        List<List<Integer>> combinationList = new ArrayList<List<Integer>>();
        for ( long i = 1; i < Math.pow(2, elements.size()); i++ ) {
            List<Integer> list = new ArrayList<Integer>();
            for ( int j = 0; j < elements.size(); j++ ) {
                if ( (i & (long) Math.pow(2, j)) > 0 ) {
                    list.add(elements.get(j));
                }
            }
            combinationList.add(list);
        }
        return combinationList;
    }
}
