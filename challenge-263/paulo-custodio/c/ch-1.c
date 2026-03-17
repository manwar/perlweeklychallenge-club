// Perl Weekly Challenge 263 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-263/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* target_index(int k, IntArray* nums) {
    IntArray* index = intarray_new();

    intarray_sort(nums);
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] == k)
            intarray_push_back(index, i);
    }

    return index;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s k nums...", argv[0]);

    int k = atoi(argv[1]);
    IntArray* nums = intarray_new();
    for (int i = 2; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* index = target_index(k, nums);
    intarray_print(index);

    intarray_free(nums);
    intarray_free(index);
}
