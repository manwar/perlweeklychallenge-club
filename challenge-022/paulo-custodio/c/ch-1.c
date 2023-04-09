/*
Challenge 022

Task #1
Write a script to print first 10 Sexy Prime Pairs. Sexy primes are prime
numbers that differ from each other by 6. For example, the numbers 5 and 11
are both sexy primes, because 11 - 5 = 6. The term "sexy prime" is a pun
stemming from the Latin word for six: sex. For more information, please
checkout wiki page.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

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

void print_sexy_primes(int count) {
    int a = 1;
    while (count > 0) {
        a = next_prime(a);
        int b = a;
        while (b < a+6)
            b = next_prime(b);
        if (b == a+6) {
            printf("(%d, %d)\n", a, b);
            count--;
        }
    }
}

int main() {
    print_sexy_primes(10);
}
