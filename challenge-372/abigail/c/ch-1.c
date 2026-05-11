# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>
# include <ctype.h>

# define NUL '\0'

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        bool in_word  = false;
        int spaces    = 0;
        int word_c    = 0;
        char ** words = NULL;

        line [linelen - 2] = NUL;  /* Trim newline and quote */

        /*
         * Iterate over the string; count the number of words and spaces
         * We skip the leading "
         */
        for (char * ptr = line + 1; * ptr; ptr ++) {
            spaces +=  isspace (* ptr);
            word_c += !isspace (* ptr) && !in_word;
            in_word = !isspace (* ptr);
        }

        /*
         * Put the words into an array -- or rather, pointers to them
         */
        if ((words = (char **) malloc (word_c * sizeof (char *))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        in_word = false;
        word_c  = 0;
        for (char * ptr = line + 1; * ptr; ptr ++) {
            if (!isspace (* ptr) && !in_word) {
                words [word_c ++] = ptr;
            }
            in_word = !isspace (* ptr);
            * ptr  *= in_word;  /* Set character to NUL if it's a space */
        }

        /*
         * Calculate the number of gaps, and spaces
         */
        int gaps    = word_c - 1;
        int per_gap = gaps ? spaces / gaps : 0;
        int end     = spaces - gaps * per_gap;

        /*
         * Print the results. Print the spaces one-by-one
         */
        printf ("%c", '"');
        for (int i = 0; i < word_c; i ++) {
            printf ("%s", words [i]);
            for (int j = 0; j < (i == word_c - 1 ? end : per_gap); j ++) {
                printf (" ");
            }
        }
        printf ("%c\n", '"');

    }
    free (line);
    exit (0);
}
