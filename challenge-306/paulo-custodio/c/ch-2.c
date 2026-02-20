#include "alloc.h"

int get_last_element(IntArray* nums) {
    while (nums->size >= 2) {
        intarray_sort(nums);
        int b1 = nums->data[nums->size - 1];
        int b2 = nums->data[nums->size - 2];
        nums->size -= 2;
        if (b1 != b2) {
            intarray_push_back(nums, b1 - b2);
        }
    }
    if (nums->size > 0)
        return nums->data[0];
    else
        return 0;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int last = get_last_element(nums);
    printf("%d\n", last);

    intarray_free(nums);
}
