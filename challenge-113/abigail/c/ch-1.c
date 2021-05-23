# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

/*     
 * For a description of the algorithm, and the proof why this is correct:
 * https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html
 */ 

typedef long long number;
typedef short     digit;

unsigned short gcds [] = {0, 1, 2, 1, 2, 5, 2, 1, 2, 1};

int main (void) {
    number N;
    digit  D;

    while (scanf ("%lld %hd", &N, &D) == 2) {
        if (D == 0) {
            printf ("%d\n", N >= 100 || N % 10 == 0 ? 1 : 0);
            continue;
        }
        if (N >= D * 10) {
            printf ("1\n");
            continue;
        }
        bool valid = false;
        for (unsigned short i = 0; i < D / gcds [D]; i ++) {
            number T = N - 10 * i - D;
            if (T >= 0 && T % D == 0) {
                printf ("1\n");
                valid = true;
                break;
            }
        }
        if (!valid) {
            printf ("0\n");
        }
    }

    return (0);
}
