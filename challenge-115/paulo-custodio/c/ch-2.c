/*
Challenge 115

TASK #2 - Largest Multiple
Submitted by: Mohammad S Anwar
You are given a list of positive integers (0-9), single digit.

Write a script to find the largest multiple of 2 that can be formed from the
list.

Examples
Input: @N = (1, 0, 2, 6)
Output: 6210

Input: @N = (1, 4, 2, 8)
Output: 8412

Input: @N = (4, 1, 7, 6)
Output: 7614
*/

#include <stdio.h>
#include <stdlib.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int reverse_cmp(const void* a, const void* b) {
    return -(*(int*)a - *(int*)b);
}

int largest_even(int nums_size, int* nums) {
    // smallest even number is last digit
    int last_digit = 10;
    for (int i = 0; i < nums_size; i++)
        if ((nums[i] % 2) == 0 && nums[i] < last_digit)
            last_digit = nums[i];
    if (last_digit == 10) return 0;

    // remove last_digit from list
    for (int i = 0; i < nums_size; i++) {
        if (nums[i] == last_digit) {
            nums[i] = nums[nums_size - 1];
            nums_size--;
            break;
        }
    }

    // sort remaining digits in descending order
    qsort(nums, nums_size, sizeof(int), reverse_cmp);

    int result = 0;
    for (int i = 0; i < nums_size; i++)
        result = result * 10 + nums[i];
    result = result * 10 + last_digit;

    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2) return EXIT_FAILURE;

    int nums_size = argc - 1;
    int* nums = (int*)check_mem(malloc(nums_size * sizeof(int)));
    for (int i = 0; i < nums_size; i++)
        nums[i] = atoi(argv[1 + i]);

    printf("%d\n", largest_even(nums_size, nums));

    free(nums);
}
