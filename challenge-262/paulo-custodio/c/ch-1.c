#include "alloc.h"

int count_max_pos_neg(IntArray* nums) {
    int count_pos = 0;
    int count_neg = 0;
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] > 0)
            count_pos++;
        else if (nums->data[i] < 0)
            count_neg++;
    }
    return MAX(count_pos, count_neg);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int max = count_max_pos_neg(nums);
    printf("%d\n", max);

    intarray_free(nums);
}
