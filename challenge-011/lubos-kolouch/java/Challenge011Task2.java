import java.util.Arrays;

/**
 * Perl Weekly Challenge 011 - Task 2.
 * Identity Matrix.
 */
public class Challenge011Task2 {

    public static int[][] createIdentityMatrix(int size) {
        int[][] identityMatrix = new int[size][size];
        for (int i = 0; i < size; i++) {
            identityMatrix[i][i] = 1;
        }
        return identityMatrix;
    }

    public static void main(String[] args) {
        int size = 4;
        if (args.length > 0) {
            try {
                size = Integer.parseInt(args[0]);
            } catch (NumberFormatException e) {
                System.err.println("Invalid size: " + args[0]);
                return;
            }
        }

        int[][] identityMatrix = createIdentityMatrix(size);

        for (int[] row : identityMatrix) {
            System.out.println(Arrays.toString(row));
        }
    }
}
