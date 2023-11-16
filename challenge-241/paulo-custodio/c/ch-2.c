/*
Challenge 241

Task 2: Prime Order
Submitted by: Mohammad S Anwar

You are given an array of unique positive integers greater than 2.

Write a script to sort them in ascending order of the count of their prime
factors, tie-breaking by ascending value.
Example 1

Input: @int = (11, 8, 27, 4)
Output: (11, 4, 8, 27))

Prime factors of 11 => 11
Prime factors of  4 => 2, 2
Prime factors of  8 => 2, 2, 2
Prime factors of 27 => 3, 3, 3
*/

#include "utarray.h"
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int n;
    UT_array* factors;
} Num;

void die(const char* message, ...) {
    va_list ap;
    va_start(ap, message);
    vfprintf(stderr, message, ap);
    fprintf(stderr, "\n");
    va_end(ap);
    exit(EXIT_FAILURE);
}

void* check_mem(void* p) {
    if (!p)
        die("Out of memory");
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

void prime_factors(UT_array* out, int n) {
    if (n < 2) {
        int p = 1;
        utarray_push_back(out, &p);
    }
    else {
        int p = 2;
        while (n > 1) {
            while (n % p == 0) {
                utarray_push_back(out, &p);
                n /= p;
            }
            p = next_prime(p);
        }
    }
}

Num* num_new(int n) {
    Num* num = check_mem(calloc(1, sizeof(Num)));
    num->n = n;
    utarray_new(num->factors, &ut_int_icd);
    prime_factors(num->factors, n);
    return num;
}

void num_free(Num* num) {
    utarray_free(num->factors);
    free(num);
}

int num_compare(const void* a_, const void* b_) {
    const Num* a = *(Num**)a_;
    const Num* b = *(Num**)b_;
    int a_size = (int)utarray_len(a->factors);
    int b_size = (int)utarray_len(b->factors);
    if (a_size != b_size)
        return a_size - b_size;
    for (size_t i = 0; i < a_size; i++) {
        int a1 = *(int*)utarray_eltptr(a->factors, i);
        int b1 = *(int*)utarray_eltptr(b->factors, i);
        if (a1 != b1)
            return a1 - b1;
    }
    return 0;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        puts("Usage: ch-2 n n n ...\n");
        exit(EXIT_FAILURE);
    }

    UT_array* nums;
    utarray_new(nums, &ut_ptr_icd);

    // parse args and compute primes
    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        Num* num = num_new(n);
        utarray_push_back(nums, &num);
    }

    // sort
    qsort(utarray_eltptr(nums, 0), utarray_len(nums), sizeof(Num*), num_compare);

    // output
    const char* sep = "";
    for (size_t i = 0; i < utarray_len(nums); i++) {
        printf("%s%d", sep, (*(Num**)utarray_eltptr(nums, i))->n);
        sep = " ";
    }

    // free data
    for (size_t i = 0; i < utarray_len(nums); i++)
        num_free(*(Num**)utarray_eltptr(nums, i));
    utarray_free(nums);
}
