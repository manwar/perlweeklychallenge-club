#include "alloc.h"

void find_jump(int prev_jumps, int pos, IntArray* nums, int* min_jumps) {
    if (pos >= nums->size-1) {  // reached the targe
        *min_jumps = MIN(*min_jumps, prev_jumps);
        return;
    }

    // how far can we jump
    int max_jump = nums->data[pos];
    if (max_jump > nums->size-1)
        max_jump = nums->size-1;

    // try all jumps
    for (int jump = 1; jump <= max_jump; jump++) {
        find_jump(prev_jumps+1, pos+jump, nums, min_jumps);
    }
}

int min_jumps(IntArray* nums) {
    int min_jumps = INT_MAX;
    find_jump(0, 0, nums, &min_jumps);
    return (min_jumps == INT_MAX) ? -1 : min_jumps;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int jumps = min_jumps(nums);
    printf("%d\n", jumps);

    intarray_free(nums);
}
