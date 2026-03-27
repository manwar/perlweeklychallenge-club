// Perl Weekly Challenge 210 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-210/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int kill_and_win(IntArray* nums) {
    if (nums->size == 0) {
        return 0;
    }
    else if (nums->size == 1) {
        return nums->data[0];
    }

    int max_score = 0;

    for (int i = 0; i < nums->size; i++) {
        int kill = nums->data[i];

        IntArray* rest = intarray_new();
        int sum = 0;
        for (int j = 0; j < nums->size; j++) {
            int n = nums->data[j];
            if (i != j && n != kill-1 && n != kill+1)
                intarray_push_back(rest, n);
            else
                sum += n;
        }

        int score = sum + kill_and_win(rest);
        max_score = MAX(max_score, score);

        intarray_free(rest);
    }

    return max_score;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int score = kill_and_win(nums);
    printf("%d\n", score);

    intarray_free(nums);
}
