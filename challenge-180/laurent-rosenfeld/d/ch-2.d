import std.stdio;

void main() {
    int[][][] tests = [[[3], [1,4,2,3,5]], [[4], [9,0,6,2,3,8,5]]];
    foreach(test; tests) {
        int i = test[0][0];
        int[] nums = test[1];
        write(i, " ", nums, "  =>  ");
        for (int j = 0; j < nums.length; j++) {
            if (nums[j] > i) {
                printf("%d ", nums[j]);
            }
        }
    writeln("");
    }
}
