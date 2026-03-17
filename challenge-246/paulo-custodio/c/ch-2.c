// Perl Weekly Challenge 246 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-246/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define ITERS       10000
#define MAX_VALUE   10

bool is_linear_recurrence(IntArray* nums, int p, int q) {
    for (int i = 2; i < nums->size; i++) {
        if (nums->data[i] != p * nums->data[i-2] + q * nums->data[i-1])
            return false;
    }
    return true;
}

int input_value() {
    return (rand() % (2*MAX_VALUE)) - MAX_VALUE;
}

bool found_solution(IntArray* nums) {
    for (int i = 0; i < ITERS; i++) {
        int p = input_value();
        int q = input_value();
        if (is_linear_recurrence(nums, p, q))
            return true;
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    bool ok = found_solution(nums);
    printf("%s\n", bool_to_string(ok));

    intarray_free(nums);
}
