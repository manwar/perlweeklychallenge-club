// Perl Weekly Challenge 223 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-223/

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

int count_primes_up_to(int n) {
    int count = 0;
    for (int i = 2; i <= n; i++)
        if (is_prime(i))
            count++;
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s num", argv[0]);

    int count = count_primes_up_to(atoi(argv[1]));
    printf("%d\n", count);
}
