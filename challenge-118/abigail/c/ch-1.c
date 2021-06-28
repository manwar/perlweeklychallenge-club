# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */


int main (void) {
    long long dec;
    while (scanf ("%lld", &dec) == 1) {
        /*
         * Find the largest power of 2 smaller than dec;
         * this is the position of the leading 1.
         */
        long long i = 1;
        int k = 0;
        for (k = 0; i <= dec; k ++, i = i << 1);
        /*
         * We overshot by 1
         */
        k -= 1;

        /*
         * Now, compare the bits
         */
        int is_palin = 1;
        for (int j = 0; j < k; k --, j ++) {
            if (((dec & (1 << j)) >> j) != ((dec & (1 << k)) >> k)) {
                is_palin = 0;
                break;
            }
        }
        printf ("%d\n", is_palin);
    }
    return (0);
}
