# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

# define NR_OF_DIGITS 10
# define ZERO         '0'

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        /*
         * Read in a line of data. Count the number of digits,
         * and put them in an array 'digits'.
         */
        char * line_ptr = line;
        int digits [NR_OF_DIGITS];
        for (size_t i = 0; i < NR_OF_DIGITS; i ++) {
            digits [i] = 0;
        }
        while (* line_ptr) {
            if (isdigit (* line_ptr)) {
                digits [* line_ptr - ZERO] ++;
            }
            line_ptr ++;
        }

        /*
         * Find the lowest even digit.
         */
        int last = -1;
        for (ssize_t i = NR_OF_DIGITS - 2; i >= 0; i -= 2) {
            if (digits [i]) {
                last = i;
            }
        }

        /*
         * Skip if the input does not contain an even digit.
         */
        if (last < 0) {
            continue;
        }
        digits [last] --;

        /*
         * Print the output
         */
        for (ssize_t i = NR_OF_DIGITS - 1; i >= 0; i --) {
            for (int j = 0; j < digits [i]; j ++) {
                printf ("%zu", i);
            }
        }
        printf ("%d\n", last);

    }
    free (line);

    return (0);
}
