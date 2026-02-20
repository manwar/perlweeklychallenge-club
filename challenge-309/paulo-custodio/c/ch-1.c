#include "alloc.h"

int smallest_gap(IntArray* nums) {
    if (nums->size < 2)
        return 0;
    int min_gap = nums->data[1] - nums->data[0];
    int min_after = nums->data[1];
    for (int i = 2; i < nums->size; i++) {
        int gap = nums->data[i] - nums->data[i-1];
        if (gap < min_gap) {
            min_gap = gap;
            min_after = nums->data[i];
        }
    }
    return min_after;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int gap = smallest_gap(nums);
    printf("%d\n", gap);
    intarray_free(nums);
}
