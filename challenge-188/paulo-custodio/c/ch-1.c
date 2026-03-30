// Perl Weekly Challenge 188 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-188/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_divisible_pairs(IntArray* nums, int k) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        for (int j = i+1; j < nums->size; j++) {
            if ((nums->data[i] + nums->data[j]) % k == 0)
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s nums... k", argv[0]);

    int k = atoi(argv[--argc]);
    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int count = count_divisible_pairs(nums, k);
    printf("%d\n", count);
    intarray_free(nums);
}
