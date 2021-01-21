/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ch-1.o < input-file
 */

# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  strlen;

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        size_t end = strlen;
        size_t begin;
        size_t output = 0;
        while (end > 0) {
            /*
             * Skip tailing whitespace
             */
            while (end > 0 && isspace (line [end - 1])) {
                end --;
            }

            /*
             * 'end' now just after the end of a word, or
             * at the beginning of the string; if the latter,
             * there is nothing left to print.
             */

            if (end <= 0) {
                break;
            }

            /*
             * Find the beginning of a word
             */
            begin = end - 1;
            while (begin > 0 && !isspace (line [begin - 1])) {
                begin --;
            }

            /*
             * Extract the word out of the string: allocate memory,
             * and copy the right part of the input.
             */
            char * word;
            if ((word = malloc ((end - begin + 1) * sizeof (char))) == NULL) {
                fprintf (stderr, "Out of memory\n");
                exit (1);
            }
            stpncpy (word, line + begin, end - begin);

            /*
             * Print the string, prepended (except the first printed word)
             * by a space.
             */
            printf ("%s%s", output ++ ? " " : "", word);

            end = begin;
        }
        printf ("\n");
    }
    free (line);

    return (0);
}
