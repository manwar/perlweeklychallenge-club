// Perl Weekly Challenge 265 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-265/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_freq(IntArray* nums, int n) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] == n)
            count++;
    }
    return count;
}

int get_freq_33(IntArray* nums) {
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        int count = count_freq(nums, n);
        if (count*100/nums->size >= 33)
            return n;
    }
    return -1;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int found = get_freq_33(nums);
    printf("%d\n", found);

    intarray_free(nums);
}
