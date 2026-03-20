// Perl Weekly Challenge 223 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-223/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int calc_product(IntArray* coins, int i) {
    int prod = 1;
    if (i-1 >= 0 && i-1 < coins->size)  prod *= coins->data[i-1];
    if (i   >= 0 && i   < coins->size)  prod *= coins->data[i  ];
    if (i+1 >= 0 && i+1 < coins->size)  prod *= coins->data[i+1];
    return prod;
}

void collect_max_coins_sub(int* max, int sum, IntArray* coins) {
    if (coins->size == 0) {
        *max = MAX(*max, sum);
        return;
    }

    for (int i = 0; i < coins->size; i++) {
        int pick = coins->data[i];
        IntArray* remaining = intarray_new();
        for (int j = 0; j < coins->size; j++) {
            if (i != j)
                intarray_push_back(remaining, coins->data[j]);
        }
        collect_max_coins_sub(max, sum+calc_product(coins, i), remaining);
        intarray_free(remaining);
    }
}

int collect_max_coins(IntArray* coins) {
    int max = 0;
    collect_max_coins_sub(&max, 0, coins);
    return max;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s coins...", argv[0]);

    IntArray* coins = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(coins, atoi(argv[i]));
    int max = collect_max_coins(coins);
    printf("%d\n", max);
    intarray_free(coins);
}
