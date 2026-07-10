# include <stdlib.h>
# include <stdio.h>
# include <sys/errno.h>

extern int errno;

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    int **  matrix;
    int     i = 0;
    int     N = 0;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        if (!N) {
            /*
             * First line; count the number of numbers
             */
            char * ptr = line;
            errno = 0;
            while (1) {
                long tmp = strtol (ptr, &ptr, 10);
                if (errno == EINVAL) {break;}
                if (errno) {
                    perror ("Cannot parse input");
                    goto END;
                }
                N ++;
            }
            /*
             * Allocate memory
             */
            if ((matrix = (int **) malloc (N * sizeof (int *))) == NULL) {
                perror ("Malloc failed");
                goto END;
            }
            for (int i = 0; i < N; i ++) {
                if ((matrix [i] = (int *) malloc (N * sizeof (int))) == NULL) {
                    perror ("Malloc failed");
                    goto END;
                }
            }
        }

        /*
         * Parse a row
         */
        char * ptr = line;
        errno = 0;
        for (int j = 0; j < N; j ++) {
            matrix [i] [j] = strtol (ptr, &ptr, 10);
            if (errno) {
                perror ("Cannot parse input");
                goto END;
            }
            /*
             * Out of bounds check; if it fails, we print false,
             * and jump to the end of the program
             */
            if (matrix [i] [j] < 1 || matrix [i] [j] > N) {
                printf ("false\n");
                goto END;
            }
        }
        i ++;
    }

    /*
     * Arrays we use to check rows and columns do not contain duplicates
     */
    int * row;
    int * col;
    if ((row = (int *) malloc ((N + 1) * sizeof (int))) == NULL) {
        perror ("Malloc failed");
        goto END;
    }
    if ((col = (int *) malloc ((N + 1) * sizeof (int))) == NULL) {
        perror ("Malloc failed");
        goto END;
    }

    /*
     * Check each row and column
     */
    for (int i = 0; i < N; i ++) {
        /*
         * Clear row/col array
         */
        for (int n = 1; n <= N; n ++) {
            row [n] = col [n] = 0;
        }
        /*
         * Set value in row/column
         */
        for (int j = 0; j < N; j ++) {
            row [matrix [i] [j]] = col [matrix [j] [i]] = 1;
        }
        /*
         * Check whether all values are set; if there are duplicates
         * in a row, by the pigeon hole principle, at least one of
         * the values in unset. If this is the case, we print 'false'
         * and jump to the end of the program.
         */
        for (int n = 1; n <= N; n ++) {
            if (!row [n] || !col [n]) {
                printf ("false\n");
                goto END;
            }
        }
    }

    /*
     * All tests succeed. Print true
     */
    printf ("true\n");

    /*
     * Clean up, and exit the program
     */
  END:
    free (line);
    exit (0);
}
