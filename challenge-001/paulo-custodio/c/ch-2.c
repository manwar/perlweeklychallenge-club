// Perl Weekly Challenge 001 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    if (argc == 2) {
        int n = atoi(argv[1]);
        for (int i = 1; i <= n; i++) {
            if (i%15==0)
                printf("fizzbuzz\n");
            else if (i%3==0)
                printf("fizz\n");
            else if (i%5==0)
                printf("buzz\n");
            else
                printf("%d\n", i);
        }
    }
}
