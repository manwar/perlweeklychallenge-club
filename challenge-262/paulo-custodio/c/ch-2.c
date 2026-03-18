// Perl Weekly Challenge 262 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-262/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_equal_divisible(int k, IntArray* nums) {
    int count = 0;
    for (int i = 0; i < nums->size-1; i++) {
        for (int j = i+1; j < nums->size; j++) {
            if (nums->data[i] == nums->data[j] && (i * j) % k == 0)
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s k nums...", argv[0]);

    int k = atoi(argv[1]);

    IntArray* nums = intarray_new();
    for (int i = 2; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int count = count_equal_divisible(k, nums);
    printf("%d\n", count);

    intarray_free(nums);
}
