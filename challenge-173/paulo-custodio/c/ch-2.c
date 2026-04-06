// Perl Weekly Challenge 173 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-173/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

uint64_t* sylvester_seq(int N) {
    uint64_t* nums = xmalloc(N * sizeof(uint64_t));
    int nums_size = 0;
    nums[nums_size++] = 2;
    uint64_t prod = 2;
    while (nums_size < (uint64_t)N) {
        uint64_t term = prod+1;
        nums[nums_size++] = term;
        prod *= term;
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    int n = atoi(argv[1]);
    uint64_t* nums = sylvester_seq(n);
    printf("(");
    for (int i = 0; i < n; i++) {
        if (i > 0)
            printf(", ");
        printf("%" PRIu64, nums[i]);
    }
    printf(")\n");
    xfree(nums);
}
