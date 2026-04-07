// Perl Weekly Challenge 164 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-164/

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

bool is_palindromic(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    int b = 0;
    int t = strlen(buffer)-1;
    while (b < t) {
        if (buffer[b] != buffer[t])
            return false;
        b++;
        t--;
    }
    return true;
}

IntArray* palindromic_primes(int N) {
    IntArray* nums = intarray_new();
    for (int p = 2; p < N; p++) {
        if (is_prime(p) && is_palindromic(p))
            intarray_push_back(nums, p);
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s N", argv[0]);

    IntArray* nums = palindromic_primes(atoi(argv[1]));
    intarray_print(nums);
    intarray_free(nums);
}
