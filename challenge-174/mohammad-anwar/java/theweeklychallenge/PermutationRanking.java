package theweeklychallenge;

/*

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #2: Permutation Ranking

    You are given a list of integers with no duplicates, e.g. [0, 1, 2].

    Write two functions, permutation2rank() which will take the list
    and determine its rank (starting at 0) in the set of possible
    permutations arranged in lexicographic order, and rank2permutation()
    which will take the list and a rank number and produce just that
    permutation.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/PermutationRanking.java
    mohammad-anwar/java$ java  theweeklychallenge.PermutationRanking

*/

import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.stream.Collectors;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class PermutationRanking extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.PermutationRanking.class);
    }

    public void test_permutation2rank() {
        int[]                 n = {1, 0, 2};
        List<List<Integer>> got = permutation2rank(n);
        List<List<Integer>> exp = List.of(
            List.of(0, 1, 2),
            List.of(0, 2, 1),
            List.of(1, 0, 2),
            List.of(1, 2, 0),
            List.of(2, 0, 1),
            List.of(2, 1, 0)
        );
        assertEquals(exp, got);
    }

    public void test_rank2permutation() {
        int[]       n = {1, 0, 2};
        Integer[] got = rank2permutation(n, 1);
        Integer[] exp = {0, 2, 1};
        assertEquals(Arrays.toString(exp), Arrays.toString(got));
    }

    public static List<List<Integer>> permutation2rank(int[] n) {
        List<List<Integer>> perm = new ArrayList<>();
        Permutation(0, n, perm);
        return sortPermutations(perm);
    }

    public static Integer[] rank2permutation(int[] n, int r) {
        List<List<Integer>> rank = permutation2rank(n);
        List<Integer> p = rank.get(r);
        return p.toArray(new Integer[p.size()]);
    }

    private static List<List<Integer>> sortPermutations(List<List<Integer>> perm) {
        String[] strPerm = new String[perm.size()];
        int i = 0;
        for(List<Integer> _perm : perm) {
            strPerm[i] = _perm.stream()
                              .map(String::valueOf)
                              .collect(Collectors.joining(""));
            i++;
        }

        Arrays.sort(strPerm);

        List<List<Integer>> sortedPerm = new ArrayList<>();
        for(int j = 0; j < strPerm.length; j++) {
            String        str = strPerm[j];
            String[] strArray = str.split("");
            int[]    intArray = new int[strArray.length];

            for(int k = 0; k < strArray.length; k++) {
                intArray[k] = Integer.parseInt(strArray[k]);
            }

            List<Integer> intList = new ArrayList<Integer>(intArray.length);
            for(int e : intArray) {
                intList.add(e);
            }

            sortedPerm.add(intList);
        }

        return sortedPerm;
    }

    // https://www.w3resource.com/java-exercises/array/java-array-exercise-68.php
    private static void Permutation(int i, int[] nums, List<List<Integer>> result) {
        if (i == nums.length - 1) {
            List<Integer> list = new ArrayList<>();
            for(int n : nums) list.add(n);
            result.add(list);
        } else {
            for(int j = i, l = nums.length; j < l; j++) {
                int temp = nums[j];
                nums[j]  = nums[i];
                nums[i]  = temp;
                Permutation(i + 1, nums, result);
                temp     = nums[j];
                nums[j]  = nums[i];
                nums[i]  = temp;
            }
        }
    }
}
