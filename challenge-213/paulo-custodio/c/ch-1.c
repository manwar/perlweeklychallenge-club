// Perl Weekly Challenge 213 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-213/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* fun_sort(IntArray* nums) {
    IntArray* even = intarray_new();
    IntArray* odd  = intarray_new();

    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        if (n % 2 == 0)
            intarray_push_back(even, n);
        else
            intarray_push_back(odd, n);
    }

    intarray_sort(even);
    intarray_sort(odd);

    IntArray* result = intarray_new();
    for (int i = 0; i < even->size; i++)
        intarray_push_back(result, even->data[i]);
    for (int i = 0; i < odd->size; i++)
        intarray_push_back(result, odd->data[i]);

    intarray_free(even);
    intarray_free(odd);

    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* result = fun_sort(nums);
    intarray_print(result);

    intarray_free(nums);
    intarray_free(result);
}
