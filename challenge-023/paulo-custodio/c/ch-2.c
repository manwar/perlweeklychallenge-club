/*
Challenge 023

Task #2
Create a script that prints Prime Decomposition of a given number. The prime
decomposition of a number is defined as a list of prime numbers which when
all multiplied together, are equal to that number. For example, the Prime
decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.
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

void prime_decomposition(int n) {
    if (n < 2) {
        printf("%d\n", n);
    }
    else {
        const char* sep = "";
        int p = 2;
        while (n > 1) {
            while (n % p == 0) {
                printf("%s%d", sep, p);
                sep = ", ";
                n /= p;
            }
            p = next_prime(p);
        }
        printf("\n");
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 n\n", stderr);
        return EXIT_FAILURE;
    }

    prime_decomposition(atoi(argv[1]));
}
