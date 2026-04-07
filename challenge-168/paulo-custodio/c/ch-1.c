// Perl Weekly Challenge 168 - Task 1 - solution by Paulo Custodio
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

typedef struct {
    int seq;
    int prev[3];
} Perrin;

void init_perrin(Perrin* perrin) {
    perrin->seq = 0;
}

int next_perrin(Perrin* perrin) {
    assert(perrin->seq >= 0);
    if (perrin->seq == 0) {
        perrin->prev[0] = 3;
        perrin->prev[1] = 0;
        perrin->prev[2] = 2;
        return perrin->prev[perrin->seq++];
    }
    else if (perrin->seq <= 2) {
        return perrin->prev[perrin->seq++];
    }
    else {
        int next = perrin->prev[0] + perrin->prev[1];
        perrin->prev[0] = perrin->prev[1];
        perrin->prev[1] = perrin->prev[2];
        perrin->prev[2] = next;
        return next;
    }
}

IntArray* perrin_primes(int N) {
    Perrin perrin;
    init_perrin(&perrin);
    IntArray* seq = intarray_new();
    while (seq->size < N) {
        int n = next_perrin(&perrin);
        if (is_prime(n) && intarray_find_index(seq, n) < 0)
            intarray_push_back(seq, n);
    }
    intarray_sort(seq);     // perrin sequence has 3, 0, 2, 3, 2, ...
    return seq;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    IntArray* seq = perrin_primes(atoi(argv[1]));
    intarray_print(seq);
    intarray_free(seq);
}
