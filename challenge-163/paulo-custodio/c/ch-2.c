// Perl Weekly Challenge 163 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-163/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int summation(IntArray* nums) {
    if (nums->size < 1)
        return 0;
    
    IntArray* next = intarray_new();
    while (nums->size > 1) {
        // compute next row
        for (int i = 1; i < nums->size; i++) {
            int prev = next->size > 0 ? next->data[next->size-1] : 0;
            intarray_push_back(next, prev + nums->data[i]);
        }
        
        // move to nums, clear next
        intarray_resize(nums, next->size);
        for (int i = 0; i < next->size; i++)
            nums->data[i] = next->data[i];
        intarray_resize(next, 0);
    }
    intarray_free(next);
    return nums->data[0];
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);
    
    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    
    int sum = summation(nums);
    printf("%d\n", sum);
    intarray_free(nums);
}
