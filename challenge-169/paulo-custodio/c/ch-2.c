// Perl Weekly Challenge 169 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-169/

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

bool is_powerfull(int n) {
    IntArray* factors = prime_factors(n);
    for (int i = 0; i < factors->size; i++) {
        int f = factors->data[i];
        if (n % (f*f) != 0) {
            intarray_free(factors);
            return false;
        }
    }
    intarray_free(factors);
    return true;
}

int ipow(int base, int exp) {
    int result = 1;
    for (;;) {
        if (exp & 1)
            result *= base;
        exp >>= 1;
        if (!exp)
            break;
        base *= base;
    }
    return result;
}

bool is_perfect(int n) {
    if (n == 1)
        return true;
    for (int exp = 2; exp <= n; exp++) {
        int power;
        for (int base = 2; (power = ipow(base, exp)) <= n; base++) {
            if (power == n)
                return true;
        }
    }
    return false;
}

bool is_aquilles(int n) {
    return is_powerfull(n) && !is_perfect(n);
}

IntArray* aquilles_sequence(int N) {
    IntArray* seq = intarray_new();
    for (int n = 1; seq->size < N; n++) {
        if (is_aquilles(n))
            intarray_push_back(seq, n);
    }
    return seq;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    IntArray* seq = aquilles_sequence(atoi(argv[1]));
    intarray_print(seq);
    intarray_free(seq);
}
