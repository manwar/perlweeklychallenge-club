// Perl Weekly Challenge 163 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-163/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int sum_and_pairs(IntArray* nums) {
    int sum = 0;
    for (int i = 0; i < nums->size; i++) {
        int a = nums->data[i];
        for (int j = i+1; j < nums->size; j++) {
            int b = nums->data[j];
            sum += a & b;
        }
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);
    
    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    
    int sum = sum_and_pairs(nums);
    printf("%d\n", sum);
    intarray_free(nums);
}
