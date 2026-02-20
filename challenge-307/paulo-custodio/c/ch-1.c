#include "alloc.h"

IntArray* check_order(IntArray* nums) {
    // get sorted list
    IntArray* sorted = intarray_new();
    intarray_resize(sorted, nums->size);
    memcpy(sorted->data, nums->data, nums->size * sizeof(int));
    intarray_sort(sorted);

    // get indices
    IntArray* indices = intarray_new();
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] != sorted->data[i])
            intarray_push_back(indices, i);
    }

    intarray_free(sorted);
    return indices;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* indices = check_order(nums);
    intarray_print(indices);

    intarray_free(indices);
    intarray_free(nums);
}
