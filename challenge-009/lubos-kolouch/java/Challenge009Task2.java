import java.util.*;

/**
 * Perl Weekly Challenge 009 - Task 2.
 * Implement standard, modified, and dense ranking.
 */
public class Challenge009Task2 {

    public static int[] standardRanking(int[] scores) {
        Integer[] sortedIndices = getSortedIndices(scores);
        int[] ranks = new int[scores.length];

        for (int i = 0; i < scores.length; i++) {
            if (i > 0 && scores[sortedIndices[i]] == scores[sortedIndices[i-1]]) {
                ranks[sortedIndices[i]] = ranks[sortedIndices[i-1]];
            } else {
                ranks[sortedIndices[i]] = i + 1;
            }
        }
        return ranks;
    }

    public static int[] modifiedRanking(int[] scores) {
        Integer[] sortedIndices = getSortedIndices(scores);
        int[] ranks = new int[scores.length];

        int i = 0;
        while (i < scores.length) {
            int j = i;
            while (j < scores.length && scores[sortedIndices[j]] == scores[sortedIndices[i]]) {
                j++;
            }
            // j is the index of the next different score (or length)
            for (int k = i; k < j; k++) {
                ranks[sortedIndices[k]] = j;
            }
            i = j;
        }
        return ranks;
    }

    public static int[] denseRanking(int[] scores) {
        Integer[] sortedIndices = getSortedIndices(scores);
        int[] ranks = new int[scores.length];

        int rank = 0;
        for (int i = 0; i < scores.length; i++) {
            if (i == 0 || scores[sortedIndices[i]] != scores[sortedIndices[i-1]]) {
                rank++;
            }
            ranks[sortedIndices[i]] = rank;
        }
        return ranks;
    }

    private static Integer[] getSortedIndices(int[] scores) {
        Integer[] indices = new Integer[scores.length];
        for (int i = 0; i < scores.length; i++) indices[i] = i;

        Arrays.sort(indices, (a, b) -> Integer.compare(scores[b], scores[a]));
        return indices;
    }

    private static void runTests() {
        int[] scores = {10, 20, 30, 20, 40, 50, 10, 30};
        // Sorted: 50, 40, 30, 30, 20, 20, 10, 10
        // Standard: 1, 2, 3, 3, 5, 5, 7, 7
        // Scores (original order): 10, 20, 30, 20, 40, 50, 10, 30
        // Standard Ranks:         7,  5,  3,  5,  2,  1,  7,  3
        // Modified Ranks (1334):  8,  6,  4,  6,  2,  1,  8,  4 (gaps before: 3,3 tied for 4th, 2,2 tied for 6th, 1,1 tied for 8th)
        // Dense Ranks:           5,  4,  3,  4,  2,  1,  5,  3

        int[] std = standardRanking(scores);
        int[] expectedStd = {7, 5, 3, 5, 2, 1, 7, 3};
        if (!Arrays.equals(std, expectedStd)) {
            throw new AssertionError("Standard ranking failed. Got " + Arrays.toString(std));
        }

        int[] mod = modifiedRanking(scores);
        int[] expectedMod = {8, 6, 4, 6, 2, 1, 8, 4};
        if (!Arrays.equals(mod, expectedMod)) {
            throw new AssertionError("Modified ranking failed. Got " + Arrays.toString(mod));
        }

        int[] dense = denseRanking(scores);
        int[] expectedDense = {5, 4, 3, 4, 2, 1, 5, 3};
        if (!Arrays.equals(dense, expectedDense)) {
            throw new AssertionError("Dense ranking failed. Got " + Arrays.toString(dense));
        }

        System.out.println("ok - Challenge 009 Task 2 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        int[] scores = {10, 20, 30, 20, 40, 50, 10, 30};
        System.out.println("Scores: " + Arrays.toString(scores));
        System.out.println("Standard Ranking: " + Arrays.toString(standardRanking(scores)));
        System.out.println("Modified Ranking: " + Arrays.toString(modifiedRanking(scores)));
        System.out.println("Dense Ranking: " + Arrays.toString(denseRanking(scores)));
    }
}
