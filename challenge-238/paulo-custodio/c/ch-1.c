// Perl Weekly Challenge 238 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-238/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* calc_running_sum(IntArray* nums) {
    IntArray* rsum = intarray_new();
    int sum = 0;
    for (int i = 0; i < nums->size; i++) {
        sum += nums->data[i];
        intarray_push_back(rsum, sum);
    }
    return rsum;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* rsum = calc_running_sum(nums);
    intarray_print(rsum);

    intarray_free(nums);
    intarray_free(rsum);
}
