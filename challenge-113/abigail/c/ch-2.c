# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

typedef long long number;

int main (void) {
    char *  line = NULL;
    size_t  len  = 0;

    while (getline (&line, &len, stdin) != -1) {
        size_t offset = 0;
        int skip;
        long long n, sum;

        /*
         * Read the numbers, calculate the sum.
         */
        sum = 0;
        while (sscanf (line + offset, "%lld%n", &n, &skip) == 1) {
            sum    += n;
            offset += skip;
        }

        /*
         * Read the numbers again, write output.
         */
        offset = 0;
        while (sscanf (line + offset, "%lld%n", &n, &skip) == 1) {
            if (offset) {
                printf (" ");
            }
            printf ("%lld", sum - n);
            offset += skip;
        }
        printf ("\n");
    }
    free (line);

    return (0);
}
