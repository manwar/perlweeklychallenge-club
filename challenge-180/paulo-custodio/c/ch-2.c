// Perl Weekly Challenge 180 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-180/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* trim_list(IntArray* nums, int n) {
    IntArray* result = intarray_new();
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] > n)
            intarray_push_back(result, nums->data[i]);
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s nums... n", argv[0]);

    int n = atoi(argv[--argc]);
    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* trimmed = trim_list(nums, n);
    intarray_print(trimmed);

    intarray_free(nums);
    intarray_free(trimmed);
}
