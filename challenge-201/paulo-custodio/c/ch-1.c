/*
Challenge 201

Task 1: Missing Numbers
Submitted by: Mohammad S Anwar

You are given an array of unique numbers.

Write a script to find out all missing numbers in the range 0..$n where $n
is the array size.

Example 1

Input: @array = (0,1,3)
Output: 2

The array size i.e. total element count is 3, so the range is 0..3.
The missing number is 2 in the given array.

Example 2

Input: @array = (0,1)
Output: 2

The array size is 2, therefore the range is 0..2.
The missing number is 2.
*/

#include <stdio.h>
#include <stdlib.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int compare(const void*a, const void* b) {
    return *(int*)a - *(int*)b;
}

void print_missing(int nums[], int nums_size) {
    qsort(nums, nums_size, sizeof(int), compare);
    for (int i = 0; i <= nums_size; i++) {      // check 0..N
        if (bsearch(&i, nums, nums_size, sizeof(int), compare) == NULL)
            printf("%d ", i);
    }
    printf("\n");
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        fputs("usage: ch-1 nums...", stderr);
        exit(EXIT_FAILURE);
    }

    int* nums = check_mem(malloc(argc*sizeof(int)));
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);
    print_missing(nums, argc);

    free(nums);
}
