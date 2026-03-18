// Perl Weekly Challenge 250 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-250/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int get_smallest_index(IntArray* nums) {
    for (int i = 0; i < nums->size; i++) {
        if (i % 10 == nums->data[i]) {
            return i;
        }
    }
    return -1;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int smallest = get_smallest_index(nums);
    printf("%d\n", smallest);

    intarray_free(nums);
}
