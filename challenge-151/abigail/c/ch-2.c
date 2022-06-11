# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int max (int a, int b) {
    return a < b ? b : a;
}

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        int * h = NULL;
        int val;
        int offset;
        int sz = 0;

        while (sscanf (line_ptr, "%d%n", &val, &offset) == 1) {
            if ((h = (int *) realloc (h, (2 + ++ sz) * sizeof (int))) == NULL) {
                perror ("Recalloc failed");
                exit (1);
            }
            h [sz - 1] = val;
            line_ptr += offset;
        }

        h [sz + 0] = 0;
        h [sz + 1] = 0;

        for (int i = sz - 1; i >= 2; i --) {
            h [i] = max (h [i] + h [i + 2], h [i + 1]);
        }

        printf ("%d\n", h [0] + h [2]);

        free (h);
    }
    free (line);

    return (0);
}
