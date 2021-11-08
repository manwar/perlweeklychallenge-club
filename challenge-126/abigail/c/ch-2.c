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
    size_t  str_len;
    char ** board = NULL;
    size_t  X = 0;
    size_t  Y = 0;


    while ((str_len = getline (&line, &len, stdin)) != -1) {
        if ((board = (char **) realloc (board, ((X + 1) * sizeof (char *)))) ==
             NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        if ((board [X] = (char *) malloc ((str_len / 2) * sizeof (char))) ==
             NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        for (size_t i = 0; i < str_len; i += 2) {
            board [X] [i / 2] = line [i];
        }
        X ++;
        if (Y == 0) {
            Y = str_len / 2;
        }
    }
    free (line);

    for (int x = 0; x < X; x ++) {
        for (int y = 0; y < Y; y ++) {
            if (y > 0) {
                printf (" ");
            }
            if (board [x] [y] == 'x') {
                printf ("x");
                continue;
            }
            int count = 0;
            for (int dx = -1; dx <= 1; dx ++) {
                if (x + dx < 0 || x + dx >= X) {
                    continue;
                }
                for (int dy = -1; dy <= 1; dy ++) {
                    if (y + dy < 0 || y + dy >= Y) {
                        continue;
                    }
                    if (dx == 0 && dy == 0) {
                        continue;
                    }
                    if (board [x + dx] [y + dy] == 'x') {
                        count ++;
                    }
                }
            }
            printf ("%d", count);
        }
        printf ("\n");
    }

    return (0);
}
