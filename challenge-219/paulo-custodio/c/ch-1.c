// Perl Weekly Challenge 219 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-219/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void square_list(IntArray* nums) {
    for (int i = 0; i < nums->size; i++)
        nums->data[i] *= nums->data[i];
    intarray_sort(nums);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    square_list(nums);

    intarray_print(nums);

    intarray_free(nums);
}
