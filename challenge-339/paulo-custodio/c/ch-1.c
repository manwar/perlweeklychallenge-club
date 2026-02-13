#include "alloc.h"

int check_pairs(int a, int b, int c, int d) {
    int diff1 = a*b-c*d;
    int diff2 = c*d-a*b;
    int max = MAX(diff1, diff2);
    return max;
}

int max_diff(int count, int* nums) {
    if (count < 4)
        return 0;

    int max = check_pairs(nums[0], nums[1], nums[2], nums[3]);
    for (int i = 0; i < count - 3; i++) {
        for (int j = i + 1; j < count - 2; j++) {
            for (int k = j + 1; k < count - 1; k++) {
                for (int l = k + 1; l < count; l++) {
                    // We have 4 distinct elements: nums[i], nums[j], nums[k], nums[l]
                    // There are exactly 3 ways to split these into 2 disjoint pairs:
                    int max1 = check_pairs(nums[i], nums[j], nums[k], nums[l]);
                    int max2 = check_pairs(nums[i], nums[k], nums[j], nums[l]);
                    int max3 = check_pairs(nums[i], nums[l], nums[j], nums[k]);
                    max = MAX(max, MAX(max1, MAX(max2, max3)));
                }
            }
        }
    }
    return max;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    argc--; argv++;
    int* nums = xmalloc(argc * sizeof(int));
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);
    int max = max_diff(argc, nums);
    printf("%d\n", max);
    xfree(nums);
}
