/*
Challenge 199

Task 2: Good Triplets
Submitted by: Mohammad S Anwar

You are given an array of integers, @array and three integers $x,$y,$z.

Write a script to find out total Good Triplets in the given array.

A triplet array[i], array[j], array[k] is good if it satisfies the following
conditions:

a) 0 <= i < j < k <= n (size of given array)
b) abs(array[i] - array[j]) <= x
c) abs(array[j] - array[k]) <= y
d) abs(array[i] - array[k]) <= z

Example 1

Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
Output: 4

Good Triplets are as below:
(3,0,1) where (i=0, j=1, k=2)
(3,0,1) where (i=0, j=1, k=3)
(3,1,1) where (i=0, j=2, k=3)
(0,1,1) where (i=1, j=2, k=3)

Example 2

Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
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

int count_good_triplets(int nums[], int nums_size, int x, int y, int z) {
    int count = 0;
    for (int i = 0; i < nums_size-2; i++) {
        for (int j = i+1; j < nums_size-1; j++) {
            for (int k = j+1; k < nums_size; k++) {
                if (abs(nums[i] - nums[j]) <= x &&
                    abs(nums[j] - nums[k]) <= y &&
                    abs(nums[i] - nums[k]) <= z)
                    count++;
            }
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc < 6) {
        fputs("usage: ch-1 nums... x y z\n", stderr);
        return EXIT_FAILURE;
    }

    int z = atoi(argv[--argc]);
    int y = atoi(argv[--argc]);
    int x = atoi(argv[--argc]);
    int* nums = check_mem(malloc(argc * sizeof(int)));
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);

    printf("%d\n", count_good_triplets(nums, argc, x, y, z));

    free(nums);
}
