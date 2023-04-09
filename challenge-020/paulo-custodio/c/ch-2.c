/*
Challenge 020

Task #2
Write a script to print the smallest pair of Amicable Numbers. For more
information, please checkout wikipedia page.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int sum_proper_divisors(int n) {
    int sum = 0;
    for (int d = 1; d < n; d++)
        if (n % d == 0)
            sum += d;
    return sum;
}

void amicable_pair(int n, int* pn, int* psum) {
    while (true) {
        n++;
        int sum = sum_proper_divisors(n);
        if (sum_proper_divisors(sum) == n && n < sum) {
            *pn = n;
            *psum = sum;
            return;
        }
    }
}

int main() {
    int n = 1;
    int sum = 0;
    amicable_pair(n, &n, &sum);
    printf("(%d,%d)\n", n, sum);
}
