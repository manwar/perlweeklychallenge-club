#include "alloc.h"

int digit_sum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int nums_digit_sum(IntArray* nums) {
    int sum = 0;
    for (int i = 0; i < nums->size; i++)
        sum += digit_sum(nums->data[i]);
    return sum;
}

int nums_sum(IntArray* nums) {
    int sum = 0;
    for (int i = 0; i < nums->size; i++)
        sum += nums->data[i];
    return sum;
}

int sum_diff(IntArray* nums) {
    return abs(nums_digit_sum(nums) - nums_sum(nums));
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int diff = sum_diff(nums);
    printf("%d\n", diff);

    intarray_free(nums);
}
