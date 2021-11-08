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
    int n;
    char  *** scores;
    number  * count;   /* Counts the number of possibilities for each
                          entry in scores */
    size_t ** lengths; /* Length of each entry in scores */
    if (scanf ("%d", &n) != 1) {
        perror ("Unexpected input");
        exit (1);
    }

    if ((scores = (char ***) malloc ((n + 3) * sizeof (char **))) == NULL) {
        perror ("Malloc scores failed");
        exit (1);
    }
    if ((count = (number *) malloc ((n + 3) * sizeof (number))) == NULL) {
        perror ("Malloc count failed");
        exit (1);
    }
    if ((lengths = (size_t **) malloc ((n + 3) * sizeof (size_t *))) == NULL) {
        perror ("Malloc lengths failed");
        exit (1);
    }

    /*
     * Initialize
     */
    count [0] = 0;
    count [1] = 0;
    count [2] = 1;

    if ((scores [2] = (char **) malloc (sizeof (char *))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    if ((scores [2] [0] = (char *) malloc (sizeof (char))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    if ((lengths [2] = (size_t *) malloc (sizeof (size_t))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    scores  [2] [0] [0] = '\0';
    lengths [2] [0]     =   0;

    /*
     * Main loop
     */
    for (int i = 3; i < n + 3; i ++) {
        /*
         * First, allocate the right amount of for scores [i] and
         * lengths [i] which is going to be
         * count [i] = count [i - 1] + count [i - 2] + count [i - 3]
         */
        count [i] = count [i - 1] + count [i - 2] + count [i - 3];
        if ((scores [i] = (char **) malloc (count [i] * sizeof (char *)))
                       == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        if ((lengths [i] = (size_t *) malloc (count [i] * sizeof (size_t)))
                       == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        /*
         * Copy strings, with single scores prepended.
         */
        number l = 0;
        for (int j = 1; j <= 3; j ++) {
            for (int k = 0; k < count [i - j]; k ++) {
                lengths [i] [l] = 2 + lengths [i - j] [k];
                if ((scores [i] [l] = (char *) malloc
                           ((lengths [i] [l] + 1) * sizeof (char))) == NULL) {
                    perror ("Malloc failed");
                    exit (1);
                }
                scores [i] [l] [0] = j + '0';
                scores [i] [l] [1] = ' ';
                strncpy (scores  [i] [l] + 2, scores [i - j] [k],
                         lengths [i - j] [k]);
                scores [i] [l] [lengths [i] [l]] = '\0';

                l ++;
            }
        }
        /*
         * We now don't need lengths [i - 3] or scores [i - 3] anymore,
         * so we can free() up the memory it uses.
         */
        if (i - 3 > 1) {
            for (int k = 0; k < count [i - 3]; k ++) {
                free (scores [i - 3] [k]);
            }
            free (scores  [i - 3]);
            free (lengths [i - 3]);
        }
    }

    /*
     * Print the wanted scores
     */
    for (int i = 0; i < count  [n + 2]; i ++) {
        printf ("%s\n", scores [n + 2] [i]);
    }

    /*
     * free() memory we have not released yet.
     */
    for (int i = n; i <= n + 2; i ++) {
        for (int k = 0; k < count [i]; k ++) {
            free (scores [i] [k]);
        }
        free (scores  [i]);
        free (lengths [i]);
    }

    free (scores);
    free (lengths);
    free (count);

    return (0);
}
