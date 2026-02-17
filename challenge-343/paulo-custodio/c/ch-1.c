#include "alloc.h"
#include <stdio.h>
#include <stdlib.h>

int closest_zero(IntArray* nums) {
    if (nums->size == 0)
        return 0;
    int closest = abs(nums->data[0]);
    for (int i = 1; i < nums->size; i++)
        closest = MIN(closest, abs(nums->data[i]));
    return closest;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    argc--; argv++;
    IntArray* nums = intarray_new();
    for (int i = 0; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    int closest = closest_zero(nums);
    printf("%d\n", closest);
    intarray_free(nums);
}
