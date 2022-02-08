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
        int * houses = NULL;
        int * best   = NULL;
        int val;
        int offset;
        int nr_of_houses = 0;

        while (sscanf (line_ptr, "%d%n", &val, &offset) == 1) {
            if ((houses = (int *)
                 realloc (houses, ++ nr_of_houses * sizeof (int))) == NULL) {
                perror ("Recalloc failed");
                exit (1);
            }
            houses [nr_of_houses - 1] = val;
            line_ptr += offset;
        }

        if ((best = (int *)
             malloc ((nr_of_houses + 2) * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }

        best [nr_of_houses + 0] = 0;
        best [nr_of_houses + 1] = 0;

        for (int i = nr_of_houses - 1; i >= 2; i --) {
            best [i] = max (houses [i] + best [i + 2], best [i + 1]);
        }

        printf ("%d\n", houses [0] + best [2]);

        free (houses);
        free (best);
    }
    free (line);

    return (0);
}
