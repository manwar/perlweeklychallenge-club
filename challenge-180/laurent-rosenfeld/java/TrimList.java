import java.util.Arrays;

public class TrimList {
    private static final int[][][] tests =
        {{{3}, {1,4,2,3,5}}, {{4}, {9,0,6,2,3,8,5}}};
    public static void main(String[] args) {
        for (int j = 0; j < tests.length; j++) {
            int i = tests[j][0][0];
            int[] nums = tests[j][1];
            System.out.printf("i = %d; nums = %s => ",
                i, Arrays.toString(nums));
            for (int k = 0; k < nums.length; k++) {
                if (nums[k] > i) {
                    System.out.printf("%d ", nums[k]);
                }
            }
        System.out.printf("%s", "\n");
        }
    }
}
