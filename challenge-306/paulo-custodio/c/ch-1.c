#include "alloc.h"

int compute_odd_sum(IntArray* nums) {
    int sum = 0;
    for (int len = 1; len <= nums->size; len += 2) {    // odd sized subarrays
        for (int i = 0; i + len <= nums->size; i++) {   // start of odd-size subarray
            for (int j = i; j < i + len; j++) {         // scan subarray
                sum += nums->data[j];
            }
        }
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int sum = compute_odd_sum(nums);
    printf("%d\n", sum);

    intarray_free(nums);
}
