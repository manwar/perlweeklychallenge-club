// Perl Weekly Challenge 214 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-214/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int remove_numbers(IntArray* nums) {
    if (nums->size < 2)
        return nums->size;

    int best_score = 0;

    // try all the runs of equal numbers
    for (int start = 0; start < nums->size; start++) {
        int end = start;
        while (end < nums->size && nums->data[start] == nums->data[end])
            end++;

        IntArray* remaining = intarray_new();
        for (int i = 0; i < nums->size; i++) {
            if (i < start || i >= end)
                intarray_push_back(remaining, nums->data[i]);
        }

        int score = (end-start)*(end-start) + remove_numbers(remaining);
        best_score = MAX(best_score, score);

        intarray_free(remaining);

        start = end - 1;
    }

    return best_score;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int score = remove_numbers(nums);
    printf("%d\n", score);

    intarray_free(nums);
}
