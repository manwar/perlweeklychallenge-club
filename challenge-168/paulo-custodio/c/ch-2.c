// Perl Weekly Challenge 168 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-168/

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
    if (n < 2) {
        intarray_push_back(factors, 1);
    }
    else {
        int p = 2;
        while (n > 1) {
            while (n % p == 0) {
                intarray_push_back(factors, p);
                n /= p;
            }
            p = next_prime(p);
        }
    }
    return factors;
}

int home_prime(int n) {
    if (n <= 1)
        return 0;
    while (!is_prime(n)) {
        IntArray* factors = prime_factors(n);
        Str* digits = str_new();
        for (int i = 0; i < factors->size; i++)
            str_printf(digits, "%d", factors->data[i]);
        n = atoi(digits->body);
        intarray_free(factors);
        str_free(digits);
    }
    return n;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    printf("%d\n", home_prime(atoi(argv[1])));
}
