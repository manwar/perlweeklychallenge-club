// Perl Weekly Challenge 285 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-285/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

static int Coins[] = {50,25,10,5,1};

int compute_num_ways(int amount, int* coins) {
    while (*coins > 1 && *coins > amount)
        coins++;
    if (*coins == 1)
        return 1;   // return in cents

    int count = 0;
    for (int v = 0; v <= amount; v += *coins) {
        count += compute_num_ways(amount-v, coins+1);
    }

    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s amount", argv[0]);

    int amount = atoi(argv[1]);
    int count = compute_num_ways(amount, Coins);
    printf("%d\n", count);
}
