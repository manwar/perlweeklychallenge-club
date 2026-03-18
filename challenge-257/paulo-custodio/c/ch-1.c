// Perl Weekly Challenge 257 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-257/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* count_smaller_than_current(IntArray* nums) {
    IntArray* counts = intarray_new();
    for (int i = 0; i < nums->size; i++) {
        int count = 0;
        for (int j = 0; j < nums->size; j++) {
            if (i != j && nums->data[j] < nums->data[i])
                count++;
        }
        intarray_push_back(counts, count);
    }
    return counts;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* counts = count_smaller_than_current(nums);
    intarray_print(counts);

    intarray_free(nums);
    intarray_free(counts);
}
