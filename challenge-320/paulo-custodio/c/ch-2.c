#include "alloc.h"

int sum_diff(IntArray* nums) {
    int sum = 0, digit_sum = 0;
    for (int i = 0; i < nums->size; i++) {
        sum += nums->data[i];
        int acc = abs(nums->data[i]);
        while (acc != 0) {
            digit_sum += acc % 10;
            acc /= 10;
        }
    }
    return abs(sum - digit_sum);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int diff = sum_diff(nums);
    printf("%d\n", diff);

    intarray_free(nums);
}
