// Perl Weekly Challenge 283 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-283/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compute_freq(int n, IntArray* nums) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] == n)
            count++;
    }
    return count;
}

int digit_count_true(IntArray* nums) {
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        if (compute_freq(i, nums) != n)
            return false;
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    bool ok = digit_count_true(nums);
    printf("%s\n", bool_to_string(ok));

    intarray_free(nums);
}
