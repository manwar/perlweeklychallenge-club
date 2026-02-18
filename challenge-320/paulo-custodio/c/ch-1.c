#include "alloc.h"

int max_count(IntArray* nums) {
    int pos = 0, neg = 0;
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] > 0)
            pos++;
        else if (nums->data[i] < 0)
            neg++;
    }
    return MAX(pos, neg);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int max = max_count(nums);
    printf("%d\n", max);

    intarray_free(nums);
}
