// Perl Weekly Challenge 235 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-235/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* dup_zeros(IntArray* nums) {
    IntArray* result = intarray_new();
    for (int i = 0; i < nums->size && result->size < nums->size; i++) {
        int n = nums->data[i];
        intarray_push_back(result, n);
        if (n == 0 && result->size < nums->size)
            intarray_push_back(result, n);
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* result = dup_zeros(nums);
    intarray_print(result);

    intarray_free(nums);
    intarray_free(result);
}
