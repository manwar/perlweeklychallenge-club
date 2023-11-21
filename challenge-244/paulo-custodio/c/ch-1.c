/*
Challenge 244

Task 1: Count Smaller
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer
at each index.
Example 1

Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.

Example 2

Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)

Example 3

Input: @int = (2, 2, 2)
Output: (0, 0, 0)
*/

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

    for (size_t i = 0; i < utarray_len(smaller); i++) {
        if (i != 0) printf(" ");
        printf("%d", *(int*)utarray_eltptr(smaller, i));
    }
    printf("\n");

    utarray_free(nums);
    utarray_free(smaller);
}
