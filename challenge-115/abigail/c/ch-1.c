# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>
# include <ctype.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */
# define NR_OF_LETTERS ('z' - 'a' + 1)

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    bool graph [NR_OF_LETTERS] [NR_OF_LETTERS];

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;

        /*
         * Initialize the matrix to all false
         */
        for (size_t i = 0; i < NR_OF_LETTERS; i ++) {
            for (size_t j = 0; j < NR_OF_LETTERS; j ++) {
                graph [i] [j] = false;
            }
        }

        /*
         * Scan the input line for beginning and end letters;
         * build a graph out of them.
         */
        while (*line_ptr) {
            while (*line_ptr && !islower (*line_ptr)) {
                line_ptr ++;  /* Skip whitespace */
            }
            if (!*line_ptr) {
                break;        /* End of string reached */
            }
            char start = *line_ptr;
            char end   = *line_ptr ++;
            while (*line_ptr && islower (*line_ptr)) {
                end = *line_ptr ++;
            }
            graph [start - 'a'] [end - 'a'] = true;
        }

        /*
         * Create the transistive closure of the graph using
         * the Floyd Warshall algorithm.
         */
        for (size_t k = 0; k < NR_OF_LETTERS; k ++) {
            for (size_t i = 0; i < NR_OF_LETTERS; i ++) {
                for (size_t j = 0; j < NR_OF_LETTERS; j ++) {
                    graph [i] [j] = graph [i] [j] ||
                                   (graph [k] [j] && graph [i] [k]);
                }
            }
        }

        /*
         * We have a loop if there is at least one node which can
         * be reached from itself.
         */
        short out = 0;
        for (size_t i = 0; i < NR_OF_LETTERS; i ++) {
            if (graph [i] [i]) {
                out = 1;
                break;
            }
        }

        printf ("%d\n", out);

    }
    free (line);

    return (0);
}
