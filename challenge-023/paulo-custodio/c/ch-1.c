/*
Challenge 023

Task #1
Create a script that prints nth order forward difference series. You should
be a able to pass the list of numbers and order number as command line
parameters. Let me show you with an example.

Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would like to
create 1st order forward difference series (Y). So using the formula
Y(i) = X(i+1) - X(i), we get the following numbers:
(9-5), (2-9), (8-2), (1-8), (6-1).
In short, the final series would be: 4, -7, 6, -7, 5.
If you noticed, it has one less number than the original series.
Similarly you can carry on 2nd order forward difference series like:
(-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.
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

int forward_diff(int* nums, int size) {
    if (size <= 1)
        return 0;

    int* diff = check_mem(malloc((size-1) * sizeof(int)));
    for (int i = 0; i < size-1; i++)
        diff[i] = nums[i+1] - nums[i];

    memcpy(nums, diff, (size-1) * sizeof(int));
    free(diff);
    return size-1;
}

int nth_forward_diff(int n, int* nums, int size) {
    for (int i = 0; i < n; i++)
        size = forward_diff(nums, size);
    return size;
}

int main(int argc, char* argv[]) {
    if (argc < 3) {
        fputs("usage: ch-1 nums\n", stderr);
        return EXIT_FAILURE;
    }

    int n = atoi(argv[1]);
    int size = argc-2;
    int* nums = check_mem(malloc(size * sizeof(int)));
    for (int i = 0; i < size; i++)
        nums[i] = atoi(argv[i+2]);

    size = nth_forward_diff(n, nums, size);

    for (int i = 0; i < size; i++)
        printf("%s%d", i==0 ? "" : ", ", nums[i]);
    printf("\n");

    free(nums);
}
