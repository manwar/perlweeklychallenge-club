// Perl Weekly Challenge 237 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-237/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int calc_greatness(IntArray* nums) {
    int n = nums->size;
    if (n <= 1) return 0;

    // copy and sort
    IntArray* sorted = intarray_new();
    for (int i = 0; i < n; i++)
        intarray_push_back(sorted, nums->data[i]);
    intarray_sort(sorted);

    int i = 0, j = 0;
    int greatness = 0;

    while (i < n && j < n) {
        if (sorted->data[j] > sorted->data[i]) {
            greatness++;
            i++;
            j++;
        } else {
            j++;
        }
    }

    intarray_free(sorted);
    return greatness;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int greatness = calc_greatness(nums);
    printf("%d\n", greatness);

    intarray_free(nums);
}
