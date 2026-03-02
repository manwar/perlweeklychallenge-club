import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Perl Weekly Challenge 003 - Task 2.
 * Generate Pascal's Triangle with a requested number of rows.
 */
class Challenge003Task2 {
    static List<List<Integer>> generatePascalTriangle(int rows) {
        List<List<Integer>> triangle = new ArrayList<>();
        for (int i = 0; i < rows; i++) {
            List<Integer> row = new ArrayList<>();
            row.add(1);
            for (int j = 1; j < i; j++) {
                row.add(triangle.get(i - 1).get(j - 1) + triangle.get(i - 1).get(j));
            }
            if (i > 0) {
                row.add(1);
            }
            triangle.add(row);
        }
        return triangle;
    }

    private static void runTests() {
        List<List<Integer>> expected3 = Arrays.asList(
            Arrays.asList(1),
            Arrays.asList(1, 1),
            Arrays.asList(1, 2, 1)
        );
        List<List<Integer>> expected5 = Arrays.asList(
            Arrays.asList(1),
            Arrays.asList(1, 1),
            Arrays.asList(1, 2, 1),
            Arrays.asList(1, 3, 3, 1),
            Arrays.asList(1, 4, 6, 4, 1)
        );

        List<List<Integer>> got3 = generatePascalTriangle(3);
        List<List<Integer>> got5 = generatePascalTriangle(5);

        if (!expected3.equals(got3)) {
            throw new AssertionError("triangle(3) mismatch: " + got3);
        }
        if (!expected5.equals(got5)) {
            throw new AssertionError("triangle(5) mismatch: " + got5);
        }

        System.out.println("ok - challenge 003 task 2 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length != 1) {
            throw new IllegalArgumentException("Usage: java Challenge003Task2 <rows>");
        }

        int rows = Integer.parseInt(args[0]);
        if (rows < 3) {
            throw new IllegalArgumentException("Pascal's Triangle must have at least 3 rows");
        }

        List<List<Integer>> triangle = generatePascalTriangle(rows);
        System.out.println("Pascal's Triangle with " + rows + " rows:");
        for (int i = 0; i < triangle.size(); i++) {
            int padCount = rows - i - 1;
            for (int p = 0; p < padCount; p++) {
                System.out.print(" ");
            }
            List<Integer> row = triangle.get(i);
            for (int j = 0; j < row.size(); j++) {
                if (j > 0) {
                    System.out.print(" ");
                }
                System.out.print(row.get(j));
            }
            System.out.println();
        }
    }
}
