// Perl Weekly Challenge 192 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-192/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int equalize(IntArray* nums) {
    // list already in equalized form
    if (nums->size < 2)
        return 0;

    // check if it is possible to equalize
    int sum = 0;
    for (int i = 0; i < nums->size; i++) {
        sum += nums->data[i];
    }
    if (sum % nums->size != 0)
        return -1;

    int moves = 0;
    while (true) {
        // find maximum difference and `from` and `to` indexes
        int max_diff = -1;
        int from = -1;
        int to = -1;
        for (int i = 0; i < nums->size; i++) {
            for (int j = i+1; j < nums->size; j++) {
                int a = nums->data[i];
                int b = nums->data[j];
                int diff = abs(a - b);
                if (diff > max_diff) {
                    max_diff = diff;
                    if (a > b) {
                        from = i; to = j;
                    }
                    else {
                        from = j; to = i;
                    }
                }
            }
        }
        if (max_diff <= 0)
            return moves;

        // do one step
        int dir = (from > to) ? -1 : 1;
        nums->data[from]--;
        nums->data[from+dir]++;
        moves++;
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int moves = equalize(nums);
    printf("%d\n", moves);

    intarray_free(nums);
}
