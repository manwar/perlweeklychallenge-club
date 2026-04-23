# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>
# include <ctype.h>
# include <string.h>

# define NUL '\0'

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char ** words;   /* From 'paragraph' */
        char ** banned;  /* Banned words */


        /*
         * Allocate initial space for the words and banned arrays
         */
        if ((words  = (char **) malloc (0 * sizeof (char *)))  == NULL) {
            perror ("malloc failed");
            exit (1);
        }
        if ((banned = (char **) malloc (0 * sizeof (char *))) == NULL) {
            perror ("malloc failed");
            exit (1);
        }

        /*
         * Parse the input string:
         *   - Lower case all characters
         *   - After encountering '//', we switch from parsing the
         *     the paragraph to parsing the banned words
         *   - If we encounter a letter, and the previous character
         *     wasn't a letter, this begins a word: reallocate space
         *     for it, and store it in the appropriate array.
         *   - Turn any non letter into a NUL character; this makes that
         *     all words are NUL terminated.
         */
        size_t words_c  = 0;
        size_t banned_c = 0;

        bool parse_banned   = false;
        bool prev_is_letter = false;
        for (char * ptr = line; * ptr; ptr ++) {
            * ptr = tolower (* ptr);
            if (isalpha (* ptr)) {
                if (!prev_is_letter) {
                    if (parse_banned) {
                        if ((banned = (char **) realloc (banned,
                                   ++ banned_c * sizeof (char *))) == NULL) {
                            perror ("Realloc failed");
                            exit (1);
                        }
                        banned [banned_c - 1] = ptr;
                    }
                    else {
                        if ((words = (char **) realloc (words,
                                   ++ words_c * sizeof (char *))) == NULL) {
                            perror ("Realloc failed");
                            exit (1);
                        }
                        words [words_c - 1] = ptr;
                    }
                }
                prev_is_letter = true;
            }
            else {
                if (!parse_banned) {
                    if (* ptr == '/' && * (ptr + 1) == '/') {
                        parse_banned = true;
                    }
                }
                * ptr = NUL;
                prev_is_letter = false;
            }
        }

        /*
         * Remove banned words; set the corresponding entry to NULL
         */
        for (size_t i = 0; i < words_c; i ++) {
            for (size_t j = 0; j < banned_c; j ++) {
                if (!strcmp (words [i], banned [j])) {
                    words [i] = NULL;
                    break;
                }
            }
        }

        /*
         * Find the word which occurs the most frequently.
         */
        char * max;
        size_t max_count = 0;

        for (size_t i = 0; i < words_c; i ++) {
            size_t count = 0;

            if (words [i] == NULL) {
                continue;
            }

            for (size_t j = i; j < words_c; j ++) {
                if (words [j] != NULL) {
                    if (!strcmp (words [i], words [j])) {
                        count ++;
                    }
                }
            }

            if (count > max_count) {
                max       = words [i];
                max_count = count;
            }
        }

        printf ("%s\n", max);

        /*
         * Free the memory allocated for the arrays
         */
        free (words);
        free (banned);
    }
    free (line);
    exit (0);
}
