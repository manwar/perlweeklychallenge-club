// Perl Weekly Challenge 291 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-291/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int middle_index(IntArray* nums) {
    for (int i = 0; i < nums->size; i++) {
        int left_sum = 0;
        for (int j = 0; j < i; j++)
            left_sum += nums->data[j];
        int right_sum = 0;
        for (int j = i+1; j < nums->size; j++)
            right_sum += nums->data[j];
        if (left_sum == right_sum)
            return i;
    }
    return -1;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int index = middle_index(nums);
    printf("%d\n", index);

    intarray_free(nums);
}
