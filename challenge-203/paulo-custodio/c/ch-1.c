/*
Challenge 203

Task 1: Special Quadruplets
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the total special quadruplets for the given array.

Special Quadruplets are such that satisfies the following 2 rules.
1) nums[a] + nums[b] + nums[c] == nums[d]
2) a < b < c < d


Example 1

Input: @nums = (1,2,3,6)
Output: 1

Since the only special quadruplets found is
$nums[0] + $nums[1] + $nums[2] == $nums[3].

Example 2

Input: @nums = (1,1,1,3,5)
Output: 4

$nums[0] + $nums[1] + $nums[2] == $nums[3]
$nums[0] + $nums[1] + $nums[3] == $nums[4]
$nums[0] + $nums[2] + $nums[3] == $nums[4]
$nums[1] + $nums[2] + $nums[3] == $nums[4]

Example 3

Input: @nums = (3,3,6,4,5)
Output: 0
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

int num_quadruplets(int nums[], int nums_size) {
    int count = 0;
    for (int a = 0; a < nums_size - 3; a++)
        for (int b = a + 1; b < nums_size - 2; b++)
            for (int c = b + 1; c < nums_size - 1; c++)
                for (int d = c + 1; d < nums_size; d++)
                    if (nums[a]+nums[b]+nums[c]==nums[d])
                        count++;
    return count;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    int* nums = check_mem(malloc(argc*sizeof(int)));
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);
    printf("%d\n", num_quadruplets(nums, argc));
    free(nums);
}
