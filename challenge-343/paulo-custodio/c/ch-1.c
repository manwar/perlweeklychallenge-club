#include "alloc.h"
#include <stdio.h>
#include <stdlib.h>

int closest_zero(int* nums, int size) {
    if (size == 0)
        return 0;
    int closest = abs(nums[0]);
    for (int i = 1; i < size; i++) {
        if (closest > abs(nums[i]))
            closest = abs(nums[i]);
    }
    return closest;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    argc--; argv++;
    int* nums = xmalloc(argc);
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);
    int closest = closest_zero(nums, argc);
    printf("%d\n", closest);
    xfree(nums);
}
