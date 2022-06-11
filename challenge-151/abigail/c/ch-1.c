# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>
# include <ctype.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        /*
         * Count the number of '|' characters; this determines
         * how many elements to allocate for our tree.
         */
        int size = 3;
        while (* line_ptr) {
            if (* line_ptr ++ == '|') {
                size = 2 * size + 1;
            }
        }
        bool * tree;
        if ((tree = (bool *) malloc (size * sizeof (bool))) == NULL) {
            perror ("Malloc tree failed");
            exit (1);
        }
        for (size_t i = 0; i < size; i ++) {
            tree [i] = false;
        }

        int D = 0;
        int i = 0;
        size_t offset = 0;
        line_ptr = line;
        /*
         * Skip leading spaces
         */
        while (* line_ptr && isspace (* line_ptr)) {
            line_ptr ++;
        }
        while (* line_ptr) {
            if (* line_ptr == '|') {
                D ++;
                i = 0;
                offset = 2 * offset + 1;
                line_ptr ++;
                continue;
            }
            if (* line_ptr == '*') {
                i ++;
                line_ptr ++;
                continue;
            }
            if (isspace (* line_ptr)) {
                while (* line_ptr && isspace (* line_ptr)) {
                    line_ptr ++;
                }
                continue;
            }
            tree [offset + i] = true;
            i ++;
            while (* line_ptr && !isspace (* line_ptr) && * line_ptr != '|') {
                line_ptr ++;
            }
        }

        int width = 1;
        int k     = 0;
        bool done = false;
        for (int d = 0; d <= D && !done; d ++) {
            for (int i = 0; i < width && !done; i ++) {
                if (tree [k] && !tree [2 * k + 1] && !tree [2 * k + 2]) {
                    printf ("%d\n", d + 1);
                    done = true;
                }
                k ++;
            }
            width *= 2;
        }

        free (tree);
    }
    free (line);

    return (0);
}
