// Perl Weekly Challenge 228 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-228/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int unique_sum(IntArray* nums) {
    IntArray* uniq = intarray_new();
    for (int i = 0; i < nums->size; i++)
        intarray_push_back(uniq, nums->data[i]);
    intarray_uniq(uniq);

    int uniq_sum = 0;
    for (int i = 0; i < uniq->size; i++) {
        int n = uniq->data[i];
        int count_occur = 0;
        for (int j = 0; j < nums->size; j++) {
            if (n == nums->data[j])
                count_occur++;
        }
        if (count_occur == 1)
            uniq_sum += n;
    }

    intarray_free(uniq);
    return uniq_sum;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int sum = unique_sum(nums);
    printf("%d\n", sum);

    intarray_free(nums);
}
