// Perl Weekly Challenge 249 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-249/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* get_pairs(IntArray* nums) {
    IntArray* pairs = intarray_new();
    if (nums->size == 0 || nums->size % 2 != 0)
        return pairs;       // empty list

    while (nums->size >= 2) {
        int item1 = intarray_pop_front(nums);
        int item2_pos = intarray_find_index(nums, item1);
        if (item2_pos < 0) {    // not found
            intarray_clear(pairs);
            return pairs;
        }
        intarray_erase(nums, item2_pos);
        intarray_push_back(pairs, item1);
    }

    if (nums->size != 0) {
        intarray_clear(pairs);
        return pairs;
    }

    return pairs;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* pairs = get_pairs(nums);
    printf("(");
    for (int i = 0; i < pairs->size; i++) {
        if (i > 0)
            printf(", ");
        printf("(%d, %d)", pairs->data[i], pairs->data[i]);
    }
    printf(")\n");

    intarray_free(nums);
    intarray_free(pairs);
}
