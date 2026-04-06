// Perl Weekly Challenge 174 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-174/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int ipow(int base, int exp) {
    assert(exp >= 0);
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

bool is_disarium(int n) {
    char buffer[32];
    sprintf(buffer, " %d", n);  // note space to start index at 1
    int len = strlen(buffer);
    int sum = 0;
    for (int i = 1; i < len; i++)
        sum += ipow((buffer[i] - '0'), i);
    return sum == n;
}

IntArray* disarium_numbers(int N) {
    IntArray* nums = intarray_new();
    for (int n = 1; nums->size < N; n++) {
        if (is_disarium(n))
            intarray_push_back(nums, n);
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s N", argv[0]);

    int N = atoi(argv[1]);
    IntArray* nums = disarium_numbers(N);
    intarray_print(nums);
    intarray_free(nums);
}
