// Perl Weekly Challenge 176 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-176/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int reverse(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    int b = 0; int t = strlen(buffer)-1;
    while (b < t) {
        SWAP(char, buffer[b], buffer[t]);
        b++; t--;
    }
    return atoi(buffer);
}

bool all_digits_odd(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    for (const char* p = buffer; *p; p++) {
        int digit = *p -'0';
        if (digit % 2 == 0)
            return false;
    }
    return true;
}

bool is_reversible(int n) {
    int rev = reverse(n);
    int sum = n + rev;
    return all_digits_odd(sum);
}

IntArray* reversible_up_to(int N) {
    IntArray* nums = intarray_new();
    for (int n = 10; n < N; n++) {
        if (is_reversible(n))
            intarray_push_back(nums, n);
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s N", argv[0]);

    int N = atoi(argv[1]);
    IntArray* nums = reversible_up_to(N);
    intarray_print(nums);
    intarray_free(nums);
}
