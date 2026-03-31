// Perl Weekly Challenge 191 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-191/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool twice_largest(IntArray* nums) {
    if (nums->size < 2)
        return true;

    // find maximum value
    int max = nums->data[0];
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        max = MAX(max, n);
    }

    // check if it is double of all other items
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        if (n != max && n*2 > max)
            return false;
    }

    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    bool ok = twice_largest(nums);
    printf("%d\n", ok ? 1 : -1);

    intarray_free(nums);
}
