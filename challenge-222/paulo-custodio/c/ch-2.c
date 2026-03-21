// Perl Weekly Challenge 222 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-222/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int get_last_member(IntArray* nums) {
    while (true) {
        if (nums->size == 0)
            return 0;
        if (nums->size == 1)
            return nums->data[0];

        intarray_sort(nums);
        int max1 = nums->data[nums->size-1];
        int max2 = nums->data[nums->size-2];
        if (max1 == max2) {
            nums->size -= 2;
        }
        else {
            nums->size -= 2;
            intarray_push_back(nums, max1-max2);
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    int last = get_last_member(nums);
    printf("%d\n", last);
    intarray_free(nums);
}
