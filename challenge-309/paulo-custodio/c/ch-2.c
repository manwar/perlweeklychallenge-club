#include "alloc.h"

int smallest_diff(IntArray* nums) {
    int min_diff = INT_MAX;
    for (int i = 0; i < nums->size-1; i++) {
        for (int j = i+1; j < nums->size; j++) {
            int diff = abs(nums->data[i] - nums->data[j]);
            min_diff = MIN(min_diff, diff);
        }
    }
    return min_diff;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int diff = smallest_diff(nums);
    printf("%d\n", diff);
    intarray_free(nums);
}
