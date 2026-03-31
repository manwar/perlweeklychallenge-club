// Perl Weekly Challenge 189 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-189/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compute_degree(IntArray* nums, int start, int end) {
    // check range
    int min = nums->data[start];
    int max = nums->data[start];
    for (int i = start; i < end; i++) {
        int n = nums->data[i];
        min = MIN(min, n);
        max = MAX(max, n);
    }
    assert(min >= 0);

    // compute max frequency
    max = 0;
    int* freq = xcalloc(max+1, sizeof(int));
    for (int i = start; i < end; i++) {
        int n = nums->data[i];
        freq[n]++;
        max = MAX(max, freq[n]);
    }
    xfree(freq);

    return max;
}

IntArray* smallest_slice(IntArray* nums) {
    int slice_start = 0;
    int slice_end = nums->size;
    int array_degree = compute_degree(nums, 0, nums->size);

    for (int start = 0; start < nums->size-2; start++) {
        for (int len = 2; len <= nums->size-start; len++) {
            int end = start + len;
            if (end > nums->size)
                continue;
            int degree = compute_degree(nums, start, end);
            if (degree == array_degree && len < slice_end-slice_start) {
                slice_start = start;
                slice_end = end;
            }
        }
    }

    // build return array
    IntArray* slice = intarray_new();
    for (int i = slice_start; i < slice_end; i++) {
        intarray_push_back(slice, nums->data[i]);
    }

    return slice;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* slice = smallest_slice(nums);
    intarray_print(slice);

    intarray_free(nums);
    intarray_free(slice);
}
