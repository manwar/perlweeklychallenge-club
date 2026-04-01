// Perl Weekly Challenge 179 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-179/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

const char *blocks[] = {
    "\u2581", "\u2582", "\u2583", "\u2584",
    "\u2585", "\u2586", "\u2587", "\u2588"
};

Str* get_sparkline(IntArray* nums) {
    Str* result = str_new();
    if (nums->size == 0)
        return result;

    int min = nums->data[0];
    int max = nums->data[0];
    for (int i = 1; i < nums->size; i++) {
        min = MIN(min, nums->data[i]);
        max = MAX(max, nums->data[i]);
    }
    assert(min >= 0);

    if (max == 0) {
        /* All values are zero (and thus equal); emit the lowest block. */
        for (int i = 0; i < nums->size; i++) {
            str_append(result, blocks[0]);
        }
        return result;
    }

    for (int i = 0; i < nums->size; i++) {
        int block = (int)((double)nums->data[i] / (double)max *
                          (sizeof(blocks) / sizeof(blocks[0]) - 1));
        str_append(result, blocks[block]);
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    Str* sparkline = get_sparkline(nums);
    printf("%s\n", sparkline->body);

    intarray_free(nums);
}
