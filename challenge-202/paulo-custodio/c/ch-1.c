/*
Challenge 202

Task 1: Consecutive Odds
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to print 1 if there are THREE consecutive odds in the given array
otherwise print 0.

Example 1

Input: @array = (1,5,3,6)
Output: 1

Example 2

Input: @array = (2,6,3,5)
Output: 0

Example 3

Input: @array = (1,2,3,4)
Output: 0

Example 4

Input: @array = (2,3,5,7)
Output: 1
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool is_odd(int n) {
    return n%2==1;
}

int three_consecutive_odds(int nums[], int nums_size) {
    for (int i=0; i < nums_size-2; i++)
        if (is_odd(nums[i]) && is_odd(nums[i+1]) && is_odd(nums[i+2]))
            return 1;
    return 0;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc < 2) {
        fputs("Usage: ch-1 nums...\n", stderr);
        return EXIT_FAILURE;
    }

    int nums_size = argc;
    int* nums = malloc(nums_size * sizeof(int));
    for (int i = 0; i < nums_size; i++)
        nums[i] = atoi(argv[i]);

    printf("%d\n", three_consecutive_odds(nums, nums_size));

    free(nums);
    return EXIT_SUCCESS;
}
