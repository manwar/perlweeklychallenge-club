// Perl Weekly Challenge 225 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-225/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* left_right_sum_diff(IntArray* nums) {
    // left sum
    IntArray* left = intarray_new();
    int sum = 0;
    intarray_push_back(left, sum);
    for (int i = 0; i < nums->size-1; i++) {
        sum += nums->data[i];
        intarray_push_back(left, sum);
    }

    // right sum
    IntArray* right = intarray_new();
    sum = 0;
    intarray_push_front(right, sum);
    for (int i = nums->size-1; i >= 1; i--) {
        sum += nums->data[i];
        intarray_push_front(right, sum);
    }

    // difference
    IntArray* diff = intarray_new();
    for (int i = 0; i < nums->size; i++)
        intarray_push_back(diff, abs(left->data[i] - right->data[i]));

    intarray_free(left);
    intarray_free(right);

    return diff;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    IntArray* diff = left_right_sum_diff(nums);
    intarray_print(diff);

    intarray_free(nums);
    intarray_free(diff);
}
