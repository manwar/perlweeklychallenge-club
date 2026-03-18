// Perl Weekly Challenge 286 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-286/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

enum Op { Min, Max };

int min_max_game(IntArray* nums) {
    while (nums->size > 1) {
        int w = 0;
        enum Op op = Min;
        for (int i = 0; i+1 < nums->size; i += 2) {
            if (op == Min) {
                nums->data[w++] = MIN(nums->data[i], nums->data[i+1]);
                op = Max;
            }
            else {
                nums->data[w++] = MAX(nums->data[i], nums->data[i+1]);
                op = Min;
            }
        }
        intarray_resize(nums, w);
    }
    return nums->size > 0 ? nums->data[0] : 0;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int result = min_max_game(nums);
    printf("%d\n", result);

    intarray_free(nums);
}
