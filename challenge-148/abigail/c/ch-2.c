# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>
# include <math.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o
 */

# define COUNT          5
# define A              0
# define B              1
# define C              2
# define SUM            3
/* Overkill, but this will do */
# define MAX_DIVISOR  100

int main (void) {
    int ** out;
    int    k = 0;

    if ((out = (int **) malloc (COUNT * sizeof (int *))) == NULL) {
        perror ("Malloc failed");
        return (1);
    }
    for (size_t i = 0; i < COUNT; i ++) {
        if ((out [i] = (int *) malloc (SUM * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            return (1);
        }
        out [i] [A]   = 999999;
        out [i] [B]   = 999999;
        out [i] [C]   = 999999;
        out [i] [SUM] = out [i] [A] + out [i] [B] + out [i] [C];
    }

    size_t max_index = 0;


    while (3 * k + 2 <= out [max_index] [SUM]) { 
        int a  = 3 * k + 2;
        int f1 =     k + 1;
        int f2 = 8 * k + 5;

        int * d1;
        int * d2;

        if ((d1 = (int *) malloc (MAX_DIVISOR * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            return (1);
        }
        if ((d2 = (int *) malloc (MAX_DIVISOR * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            return (1);
        }

        size_t d1c = 0;
        size_t d2c = 0;

        /*
         * Get the divisors for f1
         */
        for (int i = 1; i * i <= f1; i ++) {
            if (f1 % i == 0) {
                d1 [d1c ++] = i;
                if (i != f1 / i) {
                    d1 [d1c ++] = f1 / i;
                }
            }
        }

        /*
         * Get the square divisors of f2
         */
        for (int i = 1; i * i <= f2; i ++) {
            if (f2 % i == 0) {
                int s1 = (int) sqrt (i);
                int s2 = (int) sqrt (f2 / i);
                if (s1 * s1 == i) {
                    d2 [d2c ++] = s1;
                }
                if (s2 * s2 == f2 / i && s2 != s1) {
                    d2 [d2c ++] = s2;
                }
            }
        }

        for (size_t i = 0; i < d1c; i ++) {
            for (size_t j = 0; j < d2c; j ++) {
                int b = d1 [i] * d2 [j];
                int c = f1 * f1 * f2 / (b * b);
                if (a + b + c < out [max_index] [SUM]) {
                    /*
                     * Avoid duplicates
                     */
                    bool seen = false;
                    for (size_t i = 0; i < COUNT; i ++) {
                        if (out [i] [A] == a && out [i] [B] == b) {
                            seen = true;
                            break;
                        }
                    }
                    if (seen) {
                        break;
                    }

                    out [max_index] [A]   = a;
                    out [max_index] [B]   = b;
                    out [max_index] [C]   = c;
                    out [max_index] [SUM] = a + b + c;

                    /*
                     * Find the next max index
                     */
                    max_index = 0;
                    int max_sum = out [max_index] [SUM];
                    for (size_t l = 1; l < COUNT; l ++) {
                        if (out [l] [SUM] > max_sum) {
                            max_sum   = out [l] [SUM];
                            max_index = l;
                        }
                    }
                }
            }
        }
        free (d1);
        free (d2);
        k ++;
    }

    /*
     * Print the array
     */
    for (size_t i = 0; i < COUNT; i ++) {
        printf ("%d %d %d\n", out [i] [A], out [i] [B], out [i] [C]);
        free (out [i]);
    }

    free (out);
}
