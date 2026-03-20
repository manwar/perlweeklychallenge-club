// Perl Weekly Challenge 243 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-243/

#include "utarray.h"
#include <stdio.h>
#include <stdlib.h>

int sum_floor(UT_array* nums) {
    int sum = 0;
    for (size_t i = 0; i < utarray_len(nums); i++) {
        for (size_t j = 0; j < utarray_len(nums); j++) {
            sum += *(int*)utarray_eltptr(nums, i) / *(int*)utarray_eltptr(nums, j);
        }
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 3) {
        fputs("Usage: ch-2 n n n ...\n", stderr);
        exit(EXIT_FAILURE);
    }

    UT_array* nums;
    utarray_new(nums, &ut_int_icd);

    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        utarray_push_back(nums, &n);
    }

    int sum = sum_floor(nums);
    printf("%d\n", sum);

    utarray_free(nums);
}
