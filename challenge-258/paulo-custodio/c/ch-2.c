// Perl Weekly Challenge 258 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-258/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_ones(int n) {
    int count = 0;
    while (n > 0) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}

int sum_index_ones(int k, IntArray* nums) {
    int sum = 0;
    for (int i = 0; i < nums->size; i++) {
        if (count_ones(i) == k)
            sum += nums->data[i];
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s k nums...", argv[0]);

    int k = atoi(argv[1]);
    IntArray* nums = intarray_new();
    for (int i = 2; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int sum = sum_index_ones(k, nums);
    printf("%d\n", sum);

    intarray_free(nums);
}
