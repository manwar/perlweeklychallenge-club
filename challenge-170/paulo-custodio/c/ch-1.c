// Perl Weekly Challenge 170 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-170/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_prime(int n) {
    if (n <= 1)
        return false;
    if (n <= 3)
        return true;
    if ((n % 2) == 0 || (n % 3) == 0)
        return false;
    for (int i = 5; i * i <= n; i += 6)
        if ((n % i) == 0 || (n % (i + 2)) == 0)
            return false;
    return true;
}

int next_prime(int n) {
    if (n < 2)
        return 2;
    for (int p = n+1; true; p++) {
        if (is_prime(p))
            return p;
    }
}

IntArray* primorial_numbers(int n) {
    IntArray* nums = intarray_new();
    intarray_push_back(nums, 1);
    for (int p = 2; nums->size < n; p = next_prime(p)) {
        intarray_push_back(nums, nums->data[nums->size-1] * p);
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s N", argv[0]);

    int N = atoi(argv[1]);
    IntArray* nums = primorial_numbers(N);
    intarray_print(nums);
    intarray_free(nums);
}
