/*
Challenge 197

Task 1: Pattern 132
Submitted by: Mohammad S Anwar
You are given a list of integers, @list.

Write a script to find out subsequence that respect Pattern 132. Return empty array if none found.


Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < a[k] < a[j].


Example 1
Input:  @list = (3, 1, 4, 2)
Output: (1, 4, 2) respect the Pattern 132.
Example 2
Input: @list = (1, 2, 3, 4)
Output: () since no susbsequence can be found.
Example 3
Input: @list = (1, 3, 2, 4, 6, 5)
Output: (1, 3, 2) if more than one subsequence found then return the first.
Example 4
Input: @list = (1, 3, 4, 2)
Output: (1, 3, 2)
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

void print_patter132(int* nums, int nums_size) {
    printf("(");
    for (int i=0; i<nums_size-2; i++) {
        for (int j=i+1; j<nums_size-1; j++) {
            for (int k=j+1; k<nums_size; k++) {
                if (nums[i]<nums[k] && nums[k]<nums[j]) {
                    printf("%d %d %d", nums[i], nums[j], nums[k]);
                    goto end;
                }
            }
        }
    }
end:
    printf(")\n");
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

    print_patter132(nums, argc);

    free(nums);
}
