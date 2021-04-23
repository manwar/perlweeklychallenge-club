# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

# define BASE 10
typedef int number;

/*
 * Perform long division. See ../README.md for details.
 */

char * long_division (int numerator, int denominator) {
    /*
     * Calculate the maximum size of the result
     */
    size_t fraction_len =
       (numerator < denominator ? 1 :
        floor (log10 (numerator / denominator))) +  // Digits before decimal dot
                                               1 +  // Decimal dot
                                  denominator    +  // Digits after decimal dot
                                               2 +  // Parens
                                               1;   // Trailing NUL byte
    /*
     * Allocate a string to hold the caption.
     */
    char * fraction;
    if ((fraction = (char *) malloc (fraction_len * (sizeof (char)))) == NULL) {
        perror ("Mallocing string failed");
        exit (1);
    }

    /*
     * Add the first part of the result (upto, and including the dot)
     */
    int position;
    snprintf (fraction, fraction_len, "%d.%n",
                        numerator / denominator, &position);

    /*
     * Allocate memory to remember which numerators we have seen;
     * initialize the entries to 0.
     */
    number * seen;
    if ((seen = (number *) malloc (denominator * (sizeof (number)))) == NULL) {
        perror ("Mallocing seen structure failed");
        exit (1);
    }
    for (number i = 0; i < denominator; i ++) {
        seen [i] = 0;
    }

    /*
     * We already have the part before the decimal dot; for the part
     * behind it, we need numerator < denominator
     */
    numerator %= denominator;

    while (!seen [numerator]) {
        if (!numerator) {
            fraction [position] = '\0';
            return (fraction);
        }
        seen [numerator] = position;
        fraction [position] = BASE * numerator / denominator + '0';
        numerator           = BASE * numerator % denominator;
        position ++;
    }

    /*
     * We now have to place the parens -- which means shifting
     * part of the string created so far.
     */
    fraction [position + 2] = '\0';
    fraction [position + 1] = ')';
    for (int i = position; i > seen [numerator]; i --) {
        fraction [i] = fraction [i - 1];
    }
    fraction [seen [numerator]] = '(';
    return (fraction);
}



int main (void) {
    number numerator, denominator;
    while (scanf ("%d %d", &numerator, &denominator) == 2) {
        char * fraction = long_division (numerator, denominator);
        printf ("%s\n", fraction);
        free (fraction);
    }

    return (0);
}
