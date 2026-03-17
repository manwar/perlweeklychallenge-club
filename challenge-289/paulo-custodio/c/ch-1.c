#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int third_max(IntArray* nums) {
    intarray_uniq(nums);
    if (nums->size == 0)
        return 0;
    else if (nums->size >= 3)
        return nums->data[nums->size-3];
    else
        return nums->data[nums->size-1];
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int max = third_max(nums);
    printf("%d\n", max);

    intarray_free(nums);
}
