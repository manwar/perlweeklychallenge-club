// Perl Weekly Challenge 175 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-175/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int gcd(int a, int b) {
    if (a == 0)
        return b;
    else
        return gcd(b % a, a);
}

int totient(int n) {
    int count = 0;
    for (int i = 1; i <= n; i++) {
        if (gcd(n, i) == 1)
            count++;
    }
    return count;
}

bool is_perfect_totient(int n) {
    int sum = 0;
    int tot = n;
    while (tot != 1) {
        tot = totient(tot);
        sum += tot;
    }
    return sum == n;
}

IntArray* perfect_totients(int N) {
    IntArray* nums = intarray_new();
    for (int n = 1; nums->size < N; n++) {
        if (is_perfect_totient(n))
            intarray_push_back(nums, n);
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s N", argv[0]);

    int N = atoi(argv[1]);
    IntArray* nums = perfect_totients(N);
    intarray_print(nums);
    intarray_free(nums);
}
