// Perl Weekly Challenge 261 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-261/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int find_double(int n, IntArray* nums) {
    while (intarray_find_index(nums, n) >= 0)
        n *= 2;
    return n;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s n nums...", argv[0]);

    int n = atoi(argv[1]);

    IntArray* nums = intarray_new();
    for (int i = 2; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int dbl = find_double(n, nums);
    printf("%d\n", dbl);

    intarray_free(nums);
}
