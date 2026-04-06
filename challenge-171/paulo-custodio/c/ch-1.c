// Perl Weekly Challenge 171 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-171/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* divisors(int n) {
    IntArray* div = intarray_new();
    IntArray* div_high = intarray_new();
    for (int i = 1; i*i <= n; i++) {
        if (n % i == 0) {
            intarray_push_back(div, i);
            if (n / i != i)
                intarray_push_back(div_high, n / i);
        }
    }
    for (int i = div_high->size-1; i >= 0; i--)
        intarray_push_back(div, div_high->data[i]);
    intarray_free(div_high);
    return div;
}

IntArray* proper_divisors(int n) {
    IntArray* div = divisors(n);
    intarray_pop_back(div);
    return div;
}

int intarray_sum(IntArray* nums) {
    int sum = 0;
    for (int i = 0; i < nums->size; i++)
        sum += nums->data[i];
    return sum;
}

bool is_abundant(int n) {
    IntArray* div = proper_divisors(n);
    int sum = intarray_sum(div);
    bool ok = sum > n;
    intarray_free(div);
    return ok;
}

IntArray* abundant_numbers(int N) {
    IntArray* abundant = intarray_new();
    for (int n = 1; abundant->size < N; n++) {
        if (is_abundant(n))
            intarray_push_back(abundant, n);
    }
    return abundant;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s N", argv[0]);

    int N = atoi(argv[1]);
    IntArray* nums = abundant_numbers(N);
    intarray_print(nums);
    intarray_free(nums);
}
