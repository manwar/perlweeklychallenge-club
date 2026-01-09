/*
Challenge 355

Task 2: Mountain Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to return true if the given array is a valid mountain array.

An array is mountain if and only if:
1) arr.length >= 3
and
2) There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
Example 1
Input: @ints = (1, 2, 3, 4, 5)
Output: false

Example 2
Input: @ints = (0, 2, 4, 6, 4, 2, 0)
Output: true

Example 3
Input: @ints = (5, 4, 3, 2, 1)
Output: false

Example 4
Input: @ints = (1, 3, 5, 5, 4, 2)
Output: false

Example 5
Input: @ints = (1, 3, 2)
Output: true
*/

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool check_mountain(int* nums, size_t size) {
    if (size < 3)
        return false;
    if (nums[0] >= nums[1])
        return false;
    bool climbing = true;
    for (size_t i = 1; i < size; i++) {
        if (nums[i] == nums[i-1]) {         // flat
            return false;
        }
        else if (nums[i] > nums[i-1]) {     // climbing
            if (!climbing)
                return false;
        }
        else {                              // descending
            if (climbing)
                climbing = false;
        }
    }
    return !climbing;
}

int main(int argc, char*argv[]) {
    if (argc < 2) {
        fputs("Usage: ch-1 numbers...\n", stderr);
        exit(EXIT_FAILURE);
    }

    // alloc array
    size_t size = argc - 1;
    int* nums = malloc(size * sizeof(int));
    assert(nums);

    // fill array
    for (size_t i = 0; i < size; i++) {
        nums[i] = atoi(argv[i+1]);
    }

    // check if it is a mountain
    bool is_mountain = check_mountain(nums, size);

    // free memory
    free(nums);

    // output
    printf("%s\n", is_mountain ? "true" : "false");
}
