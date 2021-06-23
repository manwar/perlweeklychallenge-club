/*
Challenge 008

Challenge #1
Write a script that computes the first five perfect numbers. A perfect number
is an integer that is the sum of its positive proper divisors (all divisors
except itself). Please check Wiki for more information. This challenge was
proposed by Laurent Rosenfeld.
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

// Euclid proved that 2 ^ (p-1) * (2 ^ p - 1) is an even perfect number
// whenever 2^p - 1 is prime
int next_perfect(void) {
    static int p = 1;
    while (true) {
        p = next_prime(p);
        int f = ipow(2, p) - 1;
        if (is_prime(f))
            return ipow(2, p - 1) * f;
    }
}

int main(int argc, char* argv[]) {
    int n = 5;
    if (argc == 2)
        n = atoi(argv[1]);
    for (int i = 0; i < n; i++) {
        printf("%d\n", next_perfect());
    }
}
