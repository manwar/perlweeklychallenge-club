// Perl Weekly Challenge 221 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-221/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_arithmetic_sequence(IntArray* nums) {
    if (nums->size < 3)
        return false;
    int delta = nums->data[1] - nums->data[0];
    for (int i = 2; i < nums->size; i++) {
        if (nums->data[i] - nums->data[i-1] != delta)
            return false;
    }
    return true;
}

void longest_arithmetic_subsequence_sub(int* longest, IntArray* nums) {
    if (is_arithmetic_sequence(nums)) {
        *longest = MAX(*longest, nums->size);
        return;
    }

    // trim the tree
    if (nums->size < 3)
        return;
    if (nums->size < *longest)
        return;

    // remove one element and try again
    for (int i = 0; i < nums->size; i++) {
        IntArray* remaining = intarray_new();
        for (int j = 0; j < nums->size; j++) {
            if (i != j)
                intarray_push_back(remaining, nums->data[j]);
        }
        longest_arithmetic_subsequence_sub(longest, remaining);
        intarray_free(remaining);
    }
}

int longest_arithmetic_subsequence(IntArray* nums) {
    int longest = 0;
    longest_arithmetic_subsequence_sub(&longest, nums);
    return longest;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    int longest = longest_arithmetic_subsequence(nums);
    printf("%d\n", longest);
    intarray_free(nums);
}
