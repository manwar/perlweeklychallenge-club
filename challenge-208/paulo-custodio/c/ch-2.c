/*
Challenge 208

Task 2: Duplicate and Missing
Submitted by: Mohammad S Anwar

You are given an array of integers in sequence with one missing and one duplicate.

Write a script to find the duplicate and missing integer in the given array.
Return -1 if none found.

For the sake of this task, let us assume the array contains no more than one
duplicate and missing.

Example 1:

Input: @nums = (1,2,2,4)
Output: (2,3)

Duplicate is 2 and Missing is 3.

Example 2:

Input: @nums = (1,2,3,4)
Output: -1

No duplicate and missing found.

Example 3:

Input: @nums = (1,2,3,3)
Output: (3,4)

Duplicate is 3 and Missing is 4.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int count_nums(int* nums, int nums_size, int n) {
    int count = 0;
    for (int i = 0; i < nums_size; i++)
        if (nums[i] == n)
            count++;
    return count;
}

void print_dups_missing(int* nums, int nums_size) {
    bool found = false;
    // find dups
    for (int i = 1; i <= nums_size; i++) {
        if (count_nums(nums, nums_size, i) > 1) {
            printf("%d ", i);
            found = true;
        }
    }
    // find missing
    for (int i = 1; i <= nums_size; i++) {
        if (count_nums(nums, nums_size, i) == 0) {
            printf("%d ", i);
            found = true;
        }
    }

    if (!found)
        printf("-1");
    printf("\n");
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        fputs("usage: ch-2 nums...\n", stderr);
        return EXIT_FAILURE;
    }

    int* nums = check_mem(malloc(argc * sizeof(int)));
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);

    print_dups_missing(nums, argc);

    free(nums);
}
