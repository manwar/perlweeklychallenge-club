// Perl Weekly Challenge 169 - Task 1 - solution by Paulo Custodio
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

int number_length(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    return strlen(buffer);
}

bool is_brillant(int n) {
    IntArray* factors = prime_factors(n);
    if (factors->size == 2) {
        int a = factors->data[0];
        int b = factors->data[1];
        if (is_prime(a) && is_prime(b) &&
            number_length(a) == number_length(b)) {
            intarray_free(factors);
            return true;
        }
    }
    intarray_free(factors);
    return false;
}

IntArray* brillant_sequence(int N) {
    IntArray* seq = intarray_new();
    for (int n = 1; seq->size < N; n++) {
        if (is_brillant(n))
            intarray_push_back(seq, n);
    }
    return seq;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    IntArray* seq = brillant_sequence(atoi(argv[1]));
    intarray_print(seq);
    intarray_free(seq);
}
