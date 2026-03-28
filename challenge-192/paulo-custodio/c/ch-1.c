// Perl Weekly Challenge 192 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-192/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int flip_bits(int n) {
    if (n <= 0)
        return 0;

    unsigned mask = 1;
    while (mask <= n)
        mask <<= 1;
    mask--;

    return ~(unsigned)n & mask;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    int n = atoi(argv[1]);
    n = flip_bits(n);
    printf("%d\n", n);
}
