/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ch-2.o < input-file
 */

# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>

/*
 * Return the minimum of three size_t values.
 */
size_t min3 (size_t a, size_t b, size_t c) {
    return a < b ? a < c ? a : c
                 : b < c ? b : c;
}

/*
 * This is an implementation of the Wagner Fischer algorithm, which
 * calculates the Levenshtein distance.
 *
 * See https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm
 */
size_t LevenshteinDistance (char * first,  size_t n,
                            char * second, size_t m) {
      
    size_t ** distance;
    if ((distance = malloc ((n + 1) * sizeof (size_t *))) == NULL) {
        fprintf (stderr, "Out of memory\n");
        exit (1);
    }
    for (size_t i = 0; i <= n; i ++) {
        if ((distance [i] = malloc ((m + 1) * sizeof (size_t))) == NULL) {
            fprintf (stderr, "Out of memory\n");
            exit (1);
        }
        for (size_t j = 0; j <= m; j ++) {
            distance [i] [j] = i == 0 || j == 0 ? i + j
                   : min3 (distance [i - 1] [j]     + 1,
                           distance [i]     [j - 1] + 1,
                           distance [i - 1] [j - 1] +
                             (first [i - 1] == second [j - 1] ? 0 : 1));
        }
        if (i) {
            /*
             * We only need the previous row; freeing the memory of rows
             * we no longer need, reduces the memory usage from
             * Theta (n * m) to O (n + m)
             */
            free (distance [i - 1]);
        }
    }
    size_t out = distance [n] [m];
    free (distance [n]);
    free (distance);
    return (out);
}


int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        /*
         * Skip any leading whitespace
         */
        while (isspace (*line_ptr)) {
            line_ptr ++;
        }
        /*
         * We're now at the start of the first word;
         * scan the word, count its length.
         */
        char * first = line_ptr;
        size_t n     = 0;

        while (!isspace (*line_ptr)) {
            line_ptr ++;
            n ++;
        }

        /*
         * Terminate the first word, and advance our pointer.
         */
        *line_ptr ++ = '\0';

        /*
         * Skip over any subsequent whitespace
         */
        while (isspace (*line_ptr)) {
            line_ptr ++;
        }

        /*
         * We're now at the beginning of the second word;
         * scan it, and count its length.
         */
        char * second = line_ptr;
        size_t m      = 0;

        while (*line_ptr && !isspace (*line_ptr)) {
            line_ptr ++;
            m ++;
        }

        /*
         * Terminate the second word, before any trailing whitespace
         */
        *line_ptr ++ = '\0';

        printf ("%zu\n", LevenshteinDistance (first, n, second, m));
    }
    free (line);

    return (0);
}
