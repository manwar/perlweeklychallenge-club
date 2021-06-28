/*
Challenge 012

Challenge #1
The numbers formed by adding one to the products of the smallest primes are
called the Euclid Numbers (see wiki). Write a script that finds the smallest
Euclid Number that is not prime. This challenge was proposed by
Laurent Rosenfeld.
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

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

int next_euclid(void) {
    static int prime = 1;
    static int prime_prod = 1;

    prime = next_prime(prime);
    prime_prod *= prime;
    return prime_prod + 1;
}

int main(void) {
    int euclid;
    while (is_prime(euclid = next_euclid()))
        ;
    printf("%d\n", euclid);
}
