// Perl Weekly Challenge 244 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-244/

#include "utarray.h"
#include <stdio.h>
#include <stdlib.h>

UT_array* calc_smaller(UT_array* nums) {
    UT_array* smaller;
    utarray_new(smaller, &ut_int_icd);

    for (size_t i = 0; i < utarray_len(nums); i++) {
        int count = 0;
        for (size_t j = 0; j < utarray_len(nums); j++) {
            if (*(int*)utarray_eltptr(nums, j) < *(int*)utarray_eltptr(nums, i))
                count++;
        }
        utarray_push_back(smaller, &count);
    }
    return smaller;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("Usage: ch-1 n n n ...\n", stderr);
        exit(EXIT_FAILURE);
    }

    UT_array* nums;
    utarray_new(nums, &ut_int_icd);

    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        utarray_push_back(nums, &n);
    }

    UT_array* smaller = calc_smaller(nums);

    printf("(");
    for (size_t i = 0; i < utarray_len(smaller); i++) {
        if (i != 0) printf(", ");
        printf("%d", *(int*)utarray_eltptr(smaller, i));
    }
    printf(")\n");

    utarray_free(nums);
    utarray_free(smaller);
}
