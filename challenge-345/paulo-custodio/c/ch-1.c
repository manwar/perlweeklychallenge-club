#include "alloc.h"

IntArray* find_peeks(IntArray* nums) {
    IntArray* peeks = intarray_new();

    for (int i = 1; i < nums->size - 1; i++) {
        int peek = nums->data[i];
        if (peek > nums->data[i - 1] && peek > nums->data[i + 1]) {
            // found peek
            intarray_push_back(peeks, i);
        }
    }
    return peeks;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    argv++; argc--;
    IntArray* nums = intarray_new();
    for (int i = 0; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    IntArray* peeks = find_peeks(nums);

    if (peeks->size == 0) {
        printf("0\n");
    }
    else {
        intarray_print(peeks);
    }

    intarray_free(peeks);
    intarray_free(nums);
}
