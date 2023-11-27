/*
Challenge 244

Task 2: Group Hero
Submitted by: Mohammad S Anwar

You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations;
power is defined as the square of the largest number in a sequence, multiplied
by the smallest.

Example 1

Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
*/

#include "utarray.h"
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

int calc_min(UT_array* nums) {
    assert(utarray_len(nums) > 0);
    int n = *(int*)utarray_eltptr(nums, 0);
    for (size_t i = 1; i < utarray_len(nums); i++) {
        int m = *(int*)utarray_eltptr(nums, i);
        if (m < n)
            n = m;
    }
    return n;
}

int calc_max(UT_array* nums) {
    assert(utarray_len(nums) > 0);
    int n = *(int*)utarray_eltptr(nums, 0);
    for (size_t i = 1; i < utarray_len(nums); i++) {
        int m = *(int*)utarray_eltptr(nums, i);
        if (m > n)
            n = m;
    }
    return n;
}

int calc_power(UT_array* nums) {
    int mn = calc_min(nums);
    int mx = calc_max(nums);
    return mx * mx * mn;
}

UT_array* counters_new(int k) {
    UT_array* counters_arr;
    utarray_new(counters_arr, &ut_int_icd);

    for (int i = 0; i < k; i++) {
        int n = 0;
        utarray_push_back(counters_arr, &n);
    }
    return counters_arr;
}

void counters_free(UT_array* counters_arr) {
    utarray_free(counters_arr);
}

int* counters_ptr(UT_array* counters_arr) {
    return (int*)utarray_eltptr(counters_arr, 0);
}

// return false when wrapping arround
bool counters_inc(UT_array* counters_arr, int max) {
    int* counters = counters_ptr(counters_arr);
    int i = (int)utarray_len(counters_arr) - 1;
    while (i >= 0) {
        counters[i]++;
        if (counters[i] < max)
            return true;
        else {
            counters[i] = 0;
            i--;
        }
    }
    return false;
}

// return true if counters are all different and increasing
bool counters_unique(UT_array* counters_arr) {
    int* counters = counters_ptr(counters_arr);
    for (int i = 1; i < (int)utarray_len(counters_arr); i++) {
        if (counters[i] <= counters[i - 1])
            return false;
    }
    return true;
}

UT_array* counters_select(UT_array* counters_arr, UT_array* nums_arr) {
    UT_array* out;
    utarray_new(out, &ut_int_icd);

    int* counters = (int*)utarray_eltptr(counters_arr, 0);
    int* nums = (int*)utarray_eltptr(nums_arr, 0);

    for (int i = 0; i < (int)utarray_len(counters_arr); i++) {
        int n = nums[counters[i]];
        utarray_push_back(out, &n);
    }

    return out;
}

int compute_power_k(int k, UT_array* nums) {
    UT_array* counters_arr = counters_new(k);
    int* counters = counters_ptr(counters_arr);

    int sum = 0;
    do {
        if (counters_unique(counters_arr)) {
            UT_array* combo = counters_select(counters_arr, nums);
            sum += calc_power(combo);
            utarray_free(combo);
        }
    } while (counters_inc(counters_arr, (int)utarray_len(nums)));

    counters_free(counters_arr);

    return sum;
}

int compute_power(UT_array* nums) {
    int sum = 0;
    for (int k = 1; k <= (int)utarray_len(nums); k++)
        sum += compute_power_k(k, nums);
    return sum;
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

    int sum = compute_power(nums);

    printf("%d\n", sum);

    utarray_free(nums);
}
