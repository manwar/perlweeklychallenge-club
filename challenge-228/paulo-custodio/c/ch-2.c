// Perl Weekly Challenge 228 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-228/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_ops(IntArray* nums) {
    int ops = 0;
    while (nums->size > 0) {
        int min = nums->data[0];
        for (int i = 1; i < nums->size; i++)
            min = MIN(min, nums->data[i]);

        if (nums->data[0] == min)
            intarray_pop_front(nums);
        else {
            intarray_push_back(nums, nums->data[0]);
            intarray_pop_front(nums);
        }
        ops++;
    }
    return ops;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int ops = count_ops(nums);
    printf("%d\n", ops);

    intarray_free(nums);
}
