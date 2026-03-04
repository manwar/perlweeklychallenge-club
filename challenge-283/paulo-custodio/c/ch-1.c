#include "alloc.h"

int compute_freq(int n, IntArray* nums) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] == n)
            count++;
    }
    return count;
}

int find_uniq(IntArray* nums) {
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        if (compute_freq(n, nums) == 1)
            return n;
    }
    return -1;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int uniq = find_uniq(nums);
    printf("%d\n", uniq);

    intarray_free(nums);
}
