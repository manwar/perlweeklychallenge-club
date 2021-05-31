# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <limits.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    unsigned long long d;
    while (scanf ("%llu", &d) == 1) {
        char b [LONG_BIT + 1];
        /*
         * Transfer the decimal number into a binary representation,
         * LSB first.
         */
        for (size_t i = 0; i < LONG_BIT; i ++) {
            b [i] = (d & 1);
            d = d >> 1;
        }
        /*
         * End with a 0
         */
        b [LONG_BIT] = 0;

        /*
         * Count the number of 0s at the beginning, followed by a count of
         * the number of 1s. 
         */
        size_t count_0 = 0;
        size_t count_1 = 1;
        while (!b [count_0]) {
            count_0 ++;
        }
        while (b [count_0 + count_1]) {
            count_1 ++;
        }
        /*
         * Now, b [count_0 + count_1 - 1] == 1 and
         *      b [count_0 + count_1]     == 0.
         * Swap those two, and place the 1s and 0s
         */
        b [count_0 + count_1]     = 1;
        b [count_0 + count_1 - 1] = 0;
        count_1 --;
        for (size_t i = 0; i < count_1; i ++) {
            b [i] = 1;
        }
        for (size_t i = count_1; i < count_1 + count_0; i ++) {
            b [i] = 0;
        }

        /*
         * Turn binary expansion back to decimal
         */
        d = 0;
        unsigned long long p2 = 1;
        for (size_t i = 0; i < LONG_BIT; i ++) {
            d  += p2 * b [i];
            p2 *= 2;
        }
        printf ("%llu\n", d);
    }
}
