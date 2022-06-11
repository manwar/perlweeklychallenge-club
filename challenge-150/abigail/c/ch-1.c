# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

# define LENGTH  51

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * ptr = line;
        char fib_tmp  [    LENGTH];
        char fib_prev [    LENGTH];
        char fib_last [2 * LENGTH];
        size_t p = 0;
        size_t l = 0;
        size_t t = 0;

        /*
         * Split input
         */
        while (!isspace (* ptr)) {
            fib_prev [p ++] = * ptr ++;
        }
        while (isspace (* ptr)) {
            ptr ++;
        }
        while (!isspace (* ptr)) {
            fib_last [l ++] = * ptr ++;
        }
        while (l < LENGTH) {
            /* 
             * We could just "shift" the content of fib_last, and
             * not use fib_temp, but let's use the same algorithm
             * as we use in different languages.
             */

            /* fib_tmp  = fib_last */
            for (t = 0; t < l; t ++) {
                fib_tmp [t] = fib_last [t];
            }

            /* fib_last = fib_prev + fib_last (= fib_tmp) */
            for (l = 0; l < p; l ++) {             
                fib_last [l] = fib_prev [l];
            }
            for (size_t i = 0; i < t; i ++) {
                fib_last [l ++] = fib_tmp [i];
            }

            /* fib_prev = fib_tmp */
            for (p = 0; p < t; p ++) {
                fib_prev [p] = fib_tmp [p];
            }
        }
        printf ("%c\n", fib_last [LENGTH - 1]);
    }
    free (line);

    return (0);
}
