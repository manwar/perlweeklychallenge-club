// Perl Weekly Challenge 176 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-176/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compare(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

bool is_permuted(int n, int b) {
    char n_buffer[32], b_buffer[32];
    sprintf(n_buffer, "%d", n); qsort(n_buffer, strlen(n_buffer), sizeof(char), compare);
    sprintf(b_buffer, "%d", b); qsort(b_buffer, strlen(b_buffer), sizeof(char), compare);
    return strcmp(n_buffer, b_buffer) == 0;
}

bool is_permuted_multiple(int n, int k) {
    return is_permuted(n, k*n);
}

bool is_permuted_multiples(int n) {
    return is_permuted_multiple(n, 2) &&
           is_permuted_multiple(n, 3) &&
           is_permuted_multiple(n, 4) &&
           is_permuted_multiple(n, 5) &&
           is_permuted_multiple(n, 6);
}

int smallest_permuted_multiples() {
    for (int n = 1; true; n++) {
        if (is_permuted_multiples(n))
            return n;
    }
}

int main() {
    printf("%d\n", smallest_permuted_multiples());
}
