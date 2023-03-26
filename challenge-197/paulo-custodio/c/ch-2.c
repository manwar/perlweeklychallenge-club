/*
Challenge 197

Task 2: Wiggle Sort
Submitted by: Mohammad S Anwar
You are given a list of integers, @list.

Write a script to perform Wiggle Sort on the given list.


Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….


Example 1
Input: @list = (1,5,1,1,6,4)
Output: (1,6,1,5,1,4)
Example 2
Input: @list = (1,3,2,2,3,1)
Output: (2,3,1,3,1,2)
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

void copy_data(int* to, int to_idx, int* from, int from_idx) {
    for (; to_idx>=0; to_idx-=2)
        to[to_idx]=from[from_idx++];
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

void wiggle_sort(int* nums, int nums_size) {
    int* copy = check_mem(malloc(nums_size * sizeof(int)));
    memcpy(copy, nums, nums_size * sizeof(int));
    qsort(copy, nums_size, sizeof(int), compare);
    copy_data(nums, nums_size-2, copy, 0);
    copy_data(nums, nums_size-1, copy, nums_size/2);
    free(copy);
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

    wiggle_sort(nums, argc);

    for (int i=0; i<argc; i++)
        printf("%d ", nums[i]);
    printf("\n");

    free(nums);
}
