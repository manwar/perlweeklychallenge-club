// Perl Weekly Challenge 164 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-164/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int sum_squares_digits(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    int len = strlen(buffer);
    int sum = 0;
    for (int i = 0; i < len; i++) {
        int digit = buffer[i] - '0';
        sum += digit * digit;
    }
    return sum;
}

bool is_happy(int n) {
    IntArray* seen = intarray_new();
    while (n != 1) {
        n = sum_squares_digits(n);
        if (intarray_find_index(seen, n) >= 0) {
            intarray_free(seen);
            return false;   // repeats
        }
        intarray_push_back(seen, n);
    }
    intarray_free(seen);
    return true;            // reaches 1
}

IntArray* happy_numbers(int N) {
    IntArray* nums = intarray_new();
    for (int n = 1; nums->size < N; n++) {
        if (is_happy(n))
            intarray_push_back(nums, n);
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s N", argv[0]);

    IntArray* nums = happy_numbers(atoi(argv[1]));
    intarray_print(nums);
    intarray_free(nums);
}
