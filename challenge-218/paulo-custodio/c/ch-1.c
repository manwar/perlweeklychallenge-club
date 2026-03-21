// Perl Weekly Challenge 218 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-218/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int max_product(IntArray* nums) {
    if (nums->size < 3)
        return 0;

    int max = 0;
    for (int i = 0; i < nums->size; i++) {
        for (int j = i+1; j < nums->size; j++) {
            for (int k = j+1; k < nums->size; k++) {
                int prod = nums->data[i] * nums->data[j] * nums->data[k];
                max = MAX(max, prod);
            }
        }
    }
    return max;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int max = max_product(nums);
    printf("%d\n", max);

    intarray_free(nums);
}
