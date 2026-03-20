// Perl Weekly Challenge 222 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-222/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_matching_members(IntArray* nums) {
    IntArray* sorted = intarray_new();
    for (int i = 0; i < nums->size; i++)
        intarray_push_back(sorted, nums->data[i]);
    intarray_sort(sorted);

    int matching = 0;
    for (int i = 0; i < nums->size; i++)
        if (nums->data[i] == sorted->data[i])
            matching++;

    intarray_free(sorted);
    return matching;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    int matching = count_matching_members(nums);
    printf("%d\n", matching);
    intarray_free(nums);
}
