/*
Challenge 098

TASK #2 › Search Insert Position
Submitted by: Mohammad S Anwar
You are given a sorted array of distinct integers @N and a target $N.

Write a script to return the index of the given target if found
otherwise place the target in the sorted array and return the index.

Example 1:
Input: @N = (1, 2, 3, 4) and $N = 3
Output: 2 since the target 3 is in the array at the index 2.
Example 2:
Input: @N = (1, 3, 5, 7) and $N = 6
Output: 3 since the target 6 is missing and should be placed at
the index 3.
Example 3:
Input: @N = (12, 14, 16, 18) and $N = 10
Output: 0 since the target 10 is missing and should be placed at
the index 0.
Example 4:
Input: @N = (11, 13, 15, 17) and $N = 19
Output: 4 since the target 19 is missing and should be placed at
the index 4.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// memory allocation
void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int* nums = NULL;
int nums_size = 0;

// append number to array
void append(int n) {
    nums = check_mem(realloc(nums, ++nums_size * sizeof(int)));
    nums[nums_size-1] = n;
}

// use bsearch to find value or insert position
const int* last_b = NULL;
int compare(const void* a, const void *b) {
    last_b = (const int*)b;
    return *(int*)a - *(int*)b;
}

int search_index(int n) {
    if (!nums) {                        // empty array
        append(n);
        return 0;
    }
    else if (n > nums[nums_size - 1]) { // larger than last
        append(n);
        return nums_size - 1;
    }
    else {
        int* found = bsearch(&n, nums, nums_size, sizeof(int), compare);
        if (found)                      // found index
            return found-nums;
        else {                          // last_b has the insert position
            int last_i = last_b-nums;   // note index before realloc ...
            append(0);                  // ... in append
            memmove(nums+last_i+1, nums+last_i,
                    (nums_size-last_i-1) * sizeof(int));
            nums[last_i] = n;
            return last_i;
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("Usage: ch-2 N n0 n1 n2...", stderr);
        return EXIT_FAILURE;
    }

    int n = atoi(argv[1]);
    for (int i = 2; i < argc; i++)
        append(atoi(argv[i]));

    int pos = search_index(n);

    printf("%d\n", pos);
    const char* sep = "(";
    for (int i = 0; i < nums_size; i++) {
        printf("%s%d", sep, nums[i]);
        sep = ", ";
    }
    printf(")\n");

    free(nums);
}
