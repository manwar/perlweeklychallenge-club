// Perl Weekly Challenge 234 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-234/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_unequal_triplets(IntArray* nums) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        for (int j = i+1; j < nums->size; j++) {
            for (int k = j+1; k < nums->size; k++) {
                if (nums->data[i] != nums->data[j] &&
                    nums->data[j] != nums->data[k] &&
                    nums->data[i] != nums->data[k])
                    count++;
            }
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int count = count_unequal_triplets(nums);
    printf("%d\n", count);

    intarray_free(nums);
}
