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

        if ((best = (int *) malloc (nr_of_houses * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }

        for (int i = nr_of_houses - 1; i >= 0; i --) {
            best [i] = nr_of_houses < 2      ? houses [i]
                     : i == nr_of_houses - 1 ? houses [i]
                     : i == 0                ? houses [i]      + best [i + 2]
                     : i == nr_of_houses - 2 ? max (houses [i],  best [i + 1])
                     :                         max (houses [i] + best [i + 2],
                                                                 best [i + 1]);
        }

        printf ("%d\n", best [0]);

        free (houses);
        free (best);
    }
    free (line);

    return (0);
}
