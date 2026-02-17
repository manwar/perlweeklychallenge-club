#include "alloc.h"

int total_xor(IntArray* nums) {
    int sum = 0;
    // run trough power set
    int total = 1 << nums->size;
    for (int i = 0; i < total; i++ ) {
        int xor = 0;
        for (int j = 0; j < nums->size; j++) {
            if ((i >> j) & 1) {
                xor ^= nums->data[j];
            }
        }
        sum += xor;
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n");

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    int xor = total_xor(nums);
    printf("%d\n", xor);
    intarray_free(nums);
}
