// Perl Weekly Challenge 226 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-226/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int ops_to_zero_array(IntArray* nums) {
    intarray_uniq(nums);
    int first_non_zero = 0;
    while (first_non_zero < nums->size && nums->data[first_non_zero] == 0)
        first_non_zero++;
    return nums->size - first_non_zero;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    int ops = ops_to_zero_array(nums);
    printf("%d\n", ops);

    intarray_free(nums);
}
