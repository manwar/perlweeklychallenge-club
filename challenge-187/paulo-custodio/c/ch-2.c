// Perl Weekly Challenge 187 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-187/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* magical_triplets(IntArray* nums) {
    IntArray* result = intarray_new();
    if (nums->size < 3)
        return result;

    // reverse sort the array to get larger ints first in the result
    intarray_sort(nums);
    intarray_reverse(nums);

    int max_sum = 0;
    for (int i = 0; i < nums->size; i++) {
        int a = nums->data[i];
        for (int j = 0; j < nums->size; j++) {
            if (j == i)
                continue;
            int b = nums->data[j];
            for (int k = j+1; k < nums->size; k++) {
                if (k == j || k == i)
                    continue;
                int c = nums->data[k];
                if (a+b > c && b+c > a && a+c > b) {
                    int sum = a+b+c;
                    if (sum > max_sum) {
                        intarray_resize(result, 3);
                        result->data[0] = a;
                        result->data[1] = b;
                        result->data[2] = c;
                        max_sum = sum;
                    }
                }
            }
        }
    }

    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 4)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* triplet = magical_triplets(nums);
    intarray_print(triplet);

    intarray_free(nums);
    intarray_free(triplet);
}
