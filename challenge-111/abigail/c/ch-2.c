# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>
# include <ctype.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    char *  line         = NULL;
    size_t  len          =    0;
    char *  longest      = NULL;
    size_t  longest_size =    0;

    while (getline (&line, &len, stdin) != -1) {
        /*
         * First check whether the word has its characters
         * in lexical order.
         */
        size_t i      = 0;
        bool in_order = 1;
        while (line [i] != '\n') {
            if ((i && tolower (line [i]) < tolower (line [i - 1])) ||
                !isalpha (line [i])) {
                in_order = false;
                break;
            }
            i ++;
        }

        /*
         * If we have a word with its characters in lexical order, and
         * it's longer than the longest word found, keep the word.
         */
        if (in_order && i > longest_size) {
            longest_size = i;
            if ((longest = (char *) realloc (longest, (i + 1) * sizeof (char)))
                 == NULL) {
                perror ("Realloc failed");
                exit (1);
            }
            for (size_t j = 0; j <= i; j ++) {  /* Copies the newline as well */
                longest [j] = line [j];
            }
            longest [i + 1] = '\0';
        }
    }
    printf ("%s", longest);

    free (line);
    free (longest);

    return (0);
}
