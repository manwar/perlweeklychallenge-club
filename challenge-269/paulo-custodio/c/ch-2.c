#include "alloc.h"

void distribute_elements(IntArray* nums) {
    if (nums->size < 2)
        return;

    IntArray* arr1 = intarray_new();
    IntArray* arr2 = intarray_new();

    // distribute
    int i = 0;
    intarray_push_back(arr1, nums->data[i++]);
    intarray_push_back(arr2, nums->data[i++]);
    for (; i < nums->size; i++) {
        if (arr1->data[arr1->size-1] > arr2->data[arr2->size-1])
            intarray_push_back(arr1, nums->data[i]);
        else
            intarray_push_back(arr2, nums->data[i]);
    }

    // concatenate
    intarray_clear(nums);
    for (int i = 0; i < arr1->size; i++) {
        intarray_push_back(nums, arr1->data[i]);
    }
    for (int i = 0; i < arr2->size; i++) {
        intarray_push_back(nums, arr2->data[i]);
    }

    intarray_free(arr1);
    intarray_free(arr2);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    distribute_elements(nums);
    intarray_print(nums);

    intarray_free(nums);
}
