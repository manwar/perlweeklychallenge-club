// Perl Weekly Challenge 182 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-182/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int index_biggest_number(IntArray* nums) {
    if (nums->size == 0)
        return -1;

    int index = 0;
    int biggest = nums->data[index];
    for (int i = 1; i < nums->size; i++) {
        int n = nums->data[i];
        if (n > biggest) {
            index = i;
            biggest = n;
        }
    }
    return index;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int index = index_biggest_number(nums);
    printf("%d\n", index);

    intarray_free(nums);
}
