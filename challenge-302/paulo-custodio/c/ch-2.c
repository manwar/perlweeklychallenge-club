#include "alloc.h"

int min_peek(IntArray* nums) {
    int peek = 0;
    int min_peek = 0;
    for (int i = 0; i < nums->size; i++) {
        peek += nums->data[i];
        min_peek = MIN(min_peek, peek);
    }
    return min_peek;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int min = min_peek(nums);
    int min_start = MAX(1, 1 - min);
    printf("%d\n", min_start);
    intarray_free(nums);
}
