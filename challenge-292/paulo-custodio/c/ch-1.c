#include "alloc.h"

int get_twice_largest_index(IntArray* nums) {
    if (nums->size < 2)
        return -1;

    // find largest element
    int largest = nums->data[0];
    int largest_index = 0;
    for (int i = 1; i < nums->size; i++) {
        if (nums->data[i] > largest) {
            largest = nums->data[i];
            largest_index = i;
        }
    }

    // check if all other less or equal than half
    for (int i = 0; i < nums->size; i++) {
        if (i == largest_index)
            continue;
        if (nums->data[i]*2 > largest)
            return -1;
    }

    return largest_index;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int index = get_twice_largest_index(nums);
    printf("%d\n", index);

    intarray_free(nums);
}
