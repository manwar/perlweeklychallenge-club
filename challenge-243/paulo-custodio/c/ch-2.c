/*
Challenge 243

Task 2: Floor Sum
Submitted by: Mohammad S Anwar

You are given an array of positive integers (>=1).

Write a script to return the sum of floor(nums[i] / nums[j]) where
0 <= i,j < nums.length. The floor() function returns the integer part of the
division.

Example 1

Input: @nums = (2, 5, 9)
Output: 10

floor(2 / 5) = 0
floor(2 / 9) = 0
floor(5 / 9) = 0
floor(2 / 2) = 1
floor(5 / 5) = 1
floor(9 / 9) = 1
floor(5 / 2) = 2
floor(9 / 2) = 4
floor(9 / 5) = 1

Example 2

Input: @nums = (7, 7, 7, 7, 7, 7, 7)
Output: 49
*/

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
