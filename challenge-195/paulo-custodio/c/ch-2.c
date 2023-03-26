/*
Challenge 195

Task 2: Most Frequent Even
Submitted by: Mohammad S Anwar
You are given a list of numbers, @list.

Write a script to find most frequent even numbers in the list. In case you
get more than one even numbers then return the smallest even integer. For all
other case, return -1.

Example 1
Input: @list = (1,1,2,6,2)
Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears
the most.
Example 2
Input: @list = (1,3,5,7)
Output: -1 since no even numbers found in the list
Example 3
Input: @list = (6,4,4,6,1)
Output: 4 since there are only two even numbers 4 and 6. They both appears
the equal number of times, so pick the smallest.
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

int most_freq_even(int* nums, int nums_size) {
    int hist_size=0;
    for (int i=0; i<nums_size; i++)
        if (hist_size<nums[i])
            hist_size=nums[i];
    int* hist=check_mem(calloc(++hist_size, sizeof(int)));
    for (int i=0; i<nums_size; i++)
        hist[nums[i]]++;
    int max_count=0;
    int max_even=-1;
    for (int i=0; i<hist_size; i+=2) {
        if (hist[i]>max_count) {
            max_count=hist[i];
            max_even=i;
        }
    }
    free(hist);
    return max_even;
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

    printf("%d\n", most_freq_even(nums, argc));

    free(nums);
}
