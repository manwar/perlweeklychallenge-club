// Perl Weekly Challenge 243 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-243/

#include "utarray.h"
#include <stdio.h>
#include <stdlib.h>

int num_reverse_pairs(UT_array* nums) {
    int count = 0;
    for (size_t i = 0; i < utarray_len(nums)-1; i++) {
        for (size_t j = i+1; j < utarray_len(nums); j++) {
            if (*(int*)utarray_eltptr(nums, i) > 2 * *(int*)utarray_eltptr(nums, j))
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 3) {
        fputs("Usage: ch-1 n n n ...\n", stderr);
        exit(EXIT_FAILURE);
    }

    UT_array* nums;
    utarray_new(nums, &ut_int_icd);

    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        utarray_push_back(nums, &n);
    }

    int count = num_reverse_pairs(nums);
    printf("%d\n", count);

    utarray_free(nums);
}
