// Perl Weekly Challenge 231 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-231/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* filter_min_max(IntArray* nums) {
    IntArray* filtered = intarray_new();
    if (nums->size <= 2)
        return filtered;

    // get min and max
    int min = nums->data[0];
    int max = nums->data[0];
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        min = MIN(min, n);
        max = MAX(max, n);
    }

    // filter min and max out
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        if (n != min && n != max)
            intarray_push_back(filtered, n);
    }

    return filtered;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* filtered = filter_min_max(nums);
    if (filtered->size == 0)
        printf("-1\n");
    else
        intarray_print(filtered);

    intarray_free(nums);
    intarray_free(filtered);
}
