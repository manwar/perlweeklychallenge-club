/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ch-1.o < input-file
 */

# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  ptr;

    while ((ptr = getline (&line, &len, stdin)) != -1) {
        size_t output = 0;
        while (ptr > 0) {
            /*
             * Skip tailing whitespace
             */
            while (ptr > 0 && isspace (line [ptr - 1])) {
                ptr --;
            }

            /*
             * 'ptr' is now just after the end of a word, or
             * at the beginning of the string; if the latter,
             * there is nothing left to print.
             */
            if (ptr <= 0) {
                break;
            }

            /*
             * Terminate the string just after the newly found word
             */
            line [ptr] = '\0';

            /*
             * Find the beginning of that word
             */
            while (ptr > 0 && !isspace (line [ptr - 1])) {
                ptr --;
            }

            /*
             * Print the word, prepended (except the first printed word)
             * by a space.
             */
            printf ("%s%s", output ++ ? " " : "", &line [ptr]);
        }
        printf ("\n");
    }
    free (line);

    return (0);
}
