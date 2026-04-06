// Perl Weekly Challenge 368 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-368/

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
    if (n <= 1)
        return 2;
    do {
        n++;
    } while (!is_prime(n));
    return n;
}

IntArray* prime_factors(int n) {
    IntArray* factors = intarray_new();
    int p = 2;
    while (n > 1) {
        while (n % p == 0) {
            intarray_push_back(factors, p);
            n /= p;
        }
        p = next_prime(p);
    }
    return factors;
}

int count_prime_factors(int n, int mode) {
    IntArray* factors = prime_factors(n);
    if (mode == 0)
        intarray_uniq(factors);
    int count = factors->size;
    intarray_free(factors);
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s number mode", argv[0]);

    printf("%d\n", count_prime_factors(atoi(argv[1]), atoi(argv[2])));
}
