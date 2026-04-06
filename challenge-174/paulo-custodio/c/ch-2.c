// Perl Weekly Challenge 174 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-174/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int factorial(int n) {
    int result = 1;
    for (int i = 2; i <= n; i++)
        result *= i;
    return result;
}

// https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
int permutation2rank(IntArray* p) {
    int n = p->size;
    int fact = factorial(n-1);          // (n-1)!
    int rank = 0;

    // build all unused digits
    IntArray* digits = intarray_new();
    for (int i = 0; i < n; i++)
        intarray_push_back(digits, i);

    // collect digit ranks
    for (int i = 0; i < n-1; i++) {
        int q = intarray_find_index(digits, p->data[i]);
        rank += fact * q;
        intarray_erase(digits, q);      // remove digit p[i]
        fact /= n-1-i;                  // weight of next digit
    }
    intarray_free(digits);
    return rank;
}

// https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
IntArray* rank2permutation(IntArray* p, int rank) {
    int n = p->size;
    int fact = factorial(n-1);          // (n-1)!

    // build all unused digits
    IntArray* digits = intarray_new();
    for (int i = 0; i < n; i++)
        intarray_push_back(digits, i);

    IntArray* result = intarray_new();

    // collect digit ranks
    for (int i = 0; i < n; i++) {
        int q = rank / fact;            // by decomposing rank = q * fact + rest
        rank %= fact;
        intarray_push_back(result, digits->data[q]);
        intarray_erase(digits, q);      // remove digit at position q
        if (i != n-1)
            fact /= n-1-i;              // weight of next digit
    }
    intarray_free(digits);
    return result;
}

int main() {
    // permutation2rank
    IntArray* p = intarray_new();
    intarray_push_back(p, 1);
    intarray_push_back(p, 0);
    intarray_push_back(p, 2);
    if (permutation2rank(p) == 2)
        printf("ok 1\n");
    else
        printf("nok 1\n");
    intarray_free(p);

    // rank2permutation
    IntArray* p0 = intarray_new();
    intarray_push_back(p0, 0);
    intarray_push_back(p0, 1);
    intarray_push_back(p0, 2);
    IntArray* p1 = rank2permutation(p0, 1);
    if (p1->size == 3 && p1->data[0] == 0 && p1->data[1] == 2 && p1->data[2] == 1)
        printf("ok 2\n");
    else
        printf("nok 2\n");
    intarray_free(p0);
    intarray_free(p1);

    printf("1..2\n");
}
