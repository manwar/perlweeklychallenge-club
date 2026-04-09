# include <stdlib.h>
# include <stdio.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        /*
         * Parse input
         */
        char mode   = line [linelen - 2];
        int  number = atoi (line);

        short unsigned diff_factors = 0;
        short unsigned      factors = 0;

        /*
         * Try dividing by all odd numbers -- but use 2 if the number is 1.
         * Count different and total factors.
         *
         * Note that this way, we will never divide by a composite number --
         * if we encounter a composite number, we have already tried its
         * factors.
         */
        for (int unsigned d = 1; d * d <= number; d += 2) {
            int unsigned n = d == 1 ? 2 : d;
            if (number % n == 0) {
                diff_factors ++;
                while (number % n == 0) {
                    factors ++;
                    number /= n;
                }
            }
        }

        /*
         * And this point, number is either 1 or a large prime, not encountered
         * before. In the later case, add one of the number of factors and
         * unique factors.
         */
        if (number != 1) {
            factors ++;
            diff_factors ++;
        }

        /*
         * Print the required tally
         */
        printf ("%u\n", mode == '1' ? factors : diff_factors);
    }
    exit (0);
}
