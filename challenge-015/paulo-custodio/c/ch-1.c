/*
Challenge 015

Task #1
Write a script to generate first 10 strong and weak prime numbers.

  For example, the nth prime number is represented by p(n).

  p(1) = 2
  p(2) = 3
  p(3) = 5
  p(4) = 7
  p(5) = 11

  Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
  Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

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

int* strong_weak_primes(int N, bool want_strong) {
    int* primes = check_mem(malloc(N * sizeof(int)));
    int p1 = 2, p2 = 3, p3 = 5;
    for (int i = 0; i < N; ) {
        float avg = ((float)p1+p3)/2;
        if (want_strong) {
            if (p2 > avg)
                primes[i++] = p2;
        }
        else {
            if ((float)p2 < avg)
                primes[i++] = p2;
        }

        // next prime
        p1 = p2; p2 = p3; p3 = next_prime(p2);
    }
    return primes;
}

void print_list(int* nums, int N) {
    const char* sep = "";
    for (int i = 0; i < N; i++) {
        printf("%s%d", sep, nums[i]);
        sep = ", ";
    }
}

int main (int argc, char* argv[]) {
    int N = 10;
    if (argc == 2)
        N = atoi(argv[1]);

    int* primes = strong_weak_primes(N, true);
    printf("Strong Prime: ");
    print_list(primes, N);
    printf("\n");
    free(primes);

    primes = strong_weak_primes(N, false);
    printf("Weak Prime:   ");
    print_list(primes, N);
    printf("\n");
    free(primes);
}
