// Perl Weekly Challenge 167 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-167/

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

int rotate(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    sprintf(buffer + strlen(buffer), "%c", buffer[0]);
    return atoi(buffer + 1);
}

int num_length(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    return strlen(buffer);
}

bool has_even_digits(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    for (int i = 0; buffer[i] != '\0'; i++) {
        int digit = buffer[i] - '0';
        if (digit % 2 == 0)
            return true;
    }
    return false;
}

bool is_circular_prime(int n) {
    if (has_even_digits(n))
        return false;
    int len = num_length(n);
    for (int i = 0; i < len; i++) {
        if (!is_prime(n))
            return false;
        n = rotate(n);
    }
    return true;
}

bool is_in_list(int n, IntArray* seen) {
    return intarray_find_index(seen, n) >= 0;
}

void add_rotations_to_list(int n, IntArray* seen) {
    int len = num_length(n);
    for (int i = 0; i < len; i++) {
        if (!is_in_list(n, seen))
            intarray_push_back(seen, n);
        n = rotate(n);
    }
}

IntArray* circular_primes(int N) {
    IntArray* seq = intarray_new();
    IntArray* seen = intarray_new();
    for (int p = 100; seq->size < N; p++) {
        if (is_circular_prime(p) && !is_in_list(p, seen)) {
            intarray_push_back(seq, p);
            add_rotations_to_list(p, seen);
        }
    }
    intarray_free(seen);
    return seq;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    IntArray* seq = circular_primes(atoi(argv[1]));
    intarray_print(seq);
    intarray_free(seq);
}
