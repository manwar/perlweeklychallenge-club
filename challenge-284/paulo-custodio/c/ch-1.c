// Perl Weekly Challenge 284 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-284/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compute_freq(int n, IntArray* nums) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] == n)
            count++;
    }
    return count;
}

int lucky_integer(IntArray* nums) {
    for (int i = nums->size-1; i >= 0; i--) {
        int n = nums->data[i];
        if (n == compute_freq(n, nums))
            return n;
    }
    return -1;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int lucky = lucky_integer(nums);
    printf("%d\n", lucky);

    intarray_free(nums);
}
