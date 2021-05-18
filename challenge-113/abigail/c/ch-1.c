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

typedef long long number;
typedef short     digit;

unsigned short tens [] = {0, 0, 1, 2, 1, 0, 2, 6, 3, 8};

int main (void) {
    number N;
    digit  D;

    while (scanf ("%lld %hd", &N, &D) == 2) {
        digit D10 = D == 0 ? 100 : 10 * D;
        if (N >= D10 || (N % (D ? D : 10) == 0)) {
            printf ("1\n");
            continue;
        }
        bool valid = false;
        for (unsigned short i = 1; i <= tens [D]; i ++) {
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
