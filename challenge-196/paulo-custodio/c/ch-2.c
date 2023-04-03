/*
Challenge 196

Task 2: Range List
Submitted by: Mohammad S Anwar
You are given a sorted unique integer array, @array.

Write a script to find all possible Number Range i.e [x, y] represent range
all integers from x and y (both inclusive).


Each subsequence of two or more contiguous integers


Example 1
Input: @array = (1,3,4,5,7)
Output: [3,5]
Example 2
Input: @array = (1,2,3,6,7,9)
Output: [1,3], [6,7]
Example 3
Input: @array = (0,1,2,4,5,6,8,9)
Output: [0,2], [4,6], [8,9]
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

void print_ranges(int* nums, int nums_size) {
    printf("(");
    const char* sep="";
    for (int i=0; i<nums_size; i++) {
        int j=0;
        while (i+j<nums_size && nums[i]+j==nums[i+j])
            j++;
        if (j>1) {
            printf("%s[%d,%d]", sep, nums[i], nums[i+j-1]);
            sep=", ";
            i+=j-1;
        }
    }
    printf(")\n");
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        fputs("usage: ch-2 nums...\n", stderr);
        return EXIT_FAILURE;
    }

    int* nums = check_mem(malloc(argc * sizeof(int)));
    for (int i=0; i<argc; i++)
        nums[i]=atoi(argv[i]);

    print_ranges(nums, argc);

    free(nums);
}
