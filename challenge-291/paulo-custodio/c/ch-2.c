// Perl Weekly Challenge 291 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-291/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

double fact(int n) {
    double p = 1;
    for (int i = 2; i <= n; i++)
        p *= (double)i;
    return p;
}

int binomial(int n, int k) {
    double result = fact(n) / (fact(k) * fact(n - k));
    return (int)result;
}

int ipow(int base, int exp) {
    int result = 1;
    while (true) {
        if (exp & 1)
            result *= base;
        exp >>= 1;
        if (!exp)
            break;
        base *= base;
    }
    return result;
}

int main() {
    int n[10] = {0};

    // 1. How many different 5-card hands can be dealt?
    int N = binomial(52, 5);
    printf("N= %d\n", N);

    // 2. How many different hands of each of the 10 ranks can be dealt?
    // high card
    n[0] = (binomial(13,5)-10)*(ipow(binomial(4,1),5)-4);
    printf("n0= %d\n", n[0]);

    // one pair hand
    n[1] = binomial(13,1)*binomial(4,2)*binomial(12,3)*ipow(binomial(4,1),3);
    printf("n1= %d\n", n[1]);

    // two pair hand
    n[2] = binomial(13,2)*ipow(binomial(4,2),2)*binomial(11,1)*binomial(4,1);
    printf("n2= %d\n", n[2]);

    // three of a kind
    n[3] = binomial(13,1)*binomial(4,3)*binomial(12,2)*ipow(binomial(4,1),2);
    printf("n3= %d\n", n[3]);

    // straight hand
    n[4] = binomial(10,1)*(ipow(binomial(4,1),5)-4);
    printf("n4= %d\n", n[4]);

    // flush hand
    n[5] = (binomial(13,5)-10)*binomial(4,1);
    printf("n5= %d\n", n[5]);

    // full house hand
    n[6] = binomial(13,1)*binomial(4,3)*binomial(12,1)*binomial(4,2);
    printf("n6= %d\n", n[6]);

    // four of a kind hand
    n[7] = binomial(13,1)*binomial(4,4)*binomial(12,1)*binomial(4,1);
    printf("n7= %d\n", n[7]);

    // straight flush hand
    n[8] = binomial(10,1)*binomial(4,1)-4;
    printf("n8= %d\n", n[8]);

    // royal flush hand
    n[9] = 4;
    printf("n9= %d\n", n[9]);

    // 3. Check the ten numbers you get in step 2 by adding them together
    //    and showing that they're equal to the number you get in step 1.
    int sum = 0;
    for (int i = 0; i < sizeof(n)/sizeof(n[0]); i++)
        sum += n[i];

    assert(N == sum);
}
