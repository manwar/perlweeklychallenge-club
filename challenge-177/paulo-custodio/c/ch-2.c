// Perl Weekly Challenge 177 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-177/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool has_zero(const char* str) {
    return strchr(str, '0') != NULL;
}

void reverse(char* str) {
    int b = 0;
    int t = strlen(str)-1;
    while (b < t) {
        SWAP(char, str[b], str[t]);
        b++;
        t--;
    }
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

IntArray* palindromic_prime_cyclops_numbers(int N) {
    char buffer[32];
    char buffer_r[32];
    IntArray* nums = intarray_new();
    for (int i = 1; nums->size < N; i++) {
        // make number i 0 (reverse i)
        sprintf(buffer, "%d", i);
        if (has_zero(buffer))
            continue;       // can only have one zero
        strcpy(buffer_r, buffer);
        reverse(buffer_r);
        sprintf(buffer, "%d0%s", i, buffer_r);

        // check if it is prime
        int n = atoi(buffer);
        if (!is_prime(n))
            continue;

        intarray_push_back(nums, n);
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s N", argv[0]);

    int N = atoi(argv[1]);
    IntArray* nums = palindromic_prime_cyclops_numbers(N);
    intarray_print(nums);
    intarray_free(nums);
}
