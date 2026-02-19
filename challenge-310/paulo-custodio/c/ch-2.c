#include "alloc.h"

void sort_odd_even(IntArray* nums) {
    IntArray* even = intarray_new();
    IntArray* odd = intarray_new();

    // split
    for (int i = 0; i < nums->size; i++) {
        if (i % 2 == 0)
            intarray_push_back(even, nums->data[i]);
        else
            intarray_push_back(odd, nums->data[i]);
    }

    // sort
    intarray_sort(even);
    intarray_sort(odd);
    intarray_reverse(odd);

    // fill back
    for (int i = 0; i < nums->size; i++) {
        if (i % 2 == 0) {
            if (even->size > 0)
                nums->data[i] = intarray_pop_front(even);
        }
        else {
            if (odd->size > 0)
                nums->data[i] = intarray_pop_front(odd);
        }
    }

    intarray_free(even);
    intarray_free(odd);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    sort_odd_even(nums);
    intarray_print(nums);
    intarray_free(nums);
}
