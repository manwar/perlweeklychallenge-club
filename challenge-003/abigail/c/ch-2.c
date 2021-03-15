# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  strlen;

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        int rows = atoi (line);
        /*
         * Declare two rows, and malloc memory for thew
         */
        long long * row;
        long long * new;

        if ((row = (long long *) malloc ((rows + 1) * sizeof (long long)))
                == NULL) {
            fprintf (stderr, "Out of memory\n");
            exit (1);
        }

        if ((new = (long long *) malloc ((rows + 1) * sizeof (long long)))
                == NULL) {
            fprintf (stderr, "Out of memory\n");
            exit (1);
        }

        /*
         * 0th row
         */
        row [0] = 1;
        printf ("%lld\n", row [0]);

        for (int r = 1; r <= rows; r ++) {
            /*
             * Create the next row, and print it
             */
            for (int i = 0; i <= r; i ++) {
                new [i] = (i == 0 ? 0 : row [i - 1]) +
                          (i == r ? 0 : row [i]);
                printf ("%s%lld", i == 0 ? "" : " ", new [i]);
            }
            printf ("\n");

            /*
             * Swap the two roles
             */
            long long * tmp = new;
            new = row;
            row = tmp;
        }

        free (new);
        free (row);
    }
    free (line);

    return (0);
}
