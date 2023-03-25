/*
Challenge 197

Task 1: Move Zero
Submitted by: Mohammad S Anwar
You are given a list of integers, @list.

Write a script to move all zero, if exists, to the end while maintaining
the relative order of non-zero elements.


Example 1
Input:  @list = (1, 0, 3, 0, 0, 5)
Output: (1, 3, 5, 0, 0, 0)
Example 2
Input: @list = (1, 6, 4)
Output: (1, 6, 4)
Example 3
Input: @list = (0, 1, 0, 2, 0)
Output: (1, 2, 0, 0, 0)
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

void move_zeros(int* nums, int nums_size) {
    int* copy = check_mem(malloc(nums_size * sizeof(int)));
    memcpy(copy, nums, nums_size * sizeof(int));
    int p=0;
    for (int i=0; i<nums_size; i++)
        if (copy[i]!=0)
            nums[p++]=copy[i];
    for (int i=0; i<nums_size; i++)
        if (copy[i]==0)
            nums[p++]=copy[i];
    free(copy);
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        fputs("usage: ch-1 nums...\n", stderr);
        return EXIT_FAILURE;
    }

    int* nums = check_mem(malloc(argc * sizeof(int)));
    for (int i=0; i<argc; i++)
        nums[i]=atoi(argv[i]);

    move_zeros(nums, argc);

    for (int i=0; i<argc; i++)
        printf("%d ", nums[i]);
    printf("\n");

    free(nums);
}
