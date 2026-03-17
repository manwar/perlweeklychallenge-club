// Perl Weekly Challenge 245 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-245/

#include "utarray.h"
#include <stdio.h>
#include <stdlib.h>

int calc_largest(int prefix, UT_array* nums) {
    int largest = -1;

    // check current prefix
    if (prefix != 0 && prefix % 3 == 0 && prefix > largest)
        largest = prefix;

    // check all compinations of each number in nums
    UT_array* remain;
    utarray_new(remain, &ut_int_icd);

    for (size_t i = 0; i < utarray_len(nums); i++) {
        // create list of numbers excluding n
        int n = *(int*)utarray_eltptr(nums, i);
        utarray_clear(remain);
        utarray_concat(remain, nums);
        utarray_erase(remain, i, 1);

        int this_largest = calc_largest(prefix * 10 + n, remain);
        if (this_largest > largest)
            largest = this_largest;
    }
    utarray_free(remain);

    return largest;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("Usage: ch-2 n n n...\n", stderr);
        exit(EXIT_FAILURE);
    }

    UT_array* nums;
    utarray_new(nums, &ut_int_icd);
    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        utarray_push_back(nums, &n);
    }

    int largest = calc_largest(0, nums);
    printf("%d\n", largest);

    utarray_free(nums);
}
