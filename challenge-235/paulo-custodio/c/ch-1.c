// Perl Weekly Challenge 235 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-235/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool strictly_increasing(IntArray* nums) {
    if (nums->size < 2)
        return true;
    for (int i = 1; i < nums->size; i++) {
        if (nums->data[i] <= nums->data[i-1])
            return false;
    }
    return true;
}

bool strictly_increasing_except_one(IntArray* nums) {
    if (strictly_increasing(nums))
        return true;
    for (int i = 0; i < nums->size; i++) {
        IntArray* rest = intarray_new();
        for (int j = 0; j < nums->size; j++) {
            if (i != j)
                intarray_push_back(rest, nums->data[j]);
        }
        bool ok = strictly_increasing(rest);
        intarray_free(rest);
        if (ok)
            return true;
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    bool ok = strictly_increasing_except_one(nums);
    printf("%s\n", bool_to_string(ok));

    intarray_free(nums);
}
