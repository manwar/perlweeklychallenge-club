# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>
# include <stdbool.h>
# include <string.h>

# define NUL '\0'

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        /*
         * Count the number of words
         */
        size_t nr_of_words = 0;
        char * ptr = line;
        while (* ptr) {
            if (isspace (* ptr)) {
                nr_of_words ++;
            }
            ptr ++;
        }

        /*
         * Allocate memory for the list of words
         */
        char ** words;
        if ((words = (char **) malloc (nr_of_words *
                               sizeof (char *))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }

        /*
         * Turn the input line into a list of words
         */
        ptr = line;
        char ** word_ptr = words;
        bool prev_was_space = true;
        while (* ptr) {
            if (isspace (* ptr)) {
                * ptr = NUL;
                prev_was_space = true;
            }
            else {
                if (prev_was_space) {
                    * word_ptr ++ = ptr;
                    prev_was_space = false;
                }
            }
            ptr ++;
        }

        int count = 0;
        for (int i = 0; i < nr_of_words - 1; i ++) {
            for (int j = i + 1; j < nr_of_words; j ++) {
                char * w1 = words [i];
                char * w2 = words [j];
                if (strlen (w2) > strlen (w1)) {
                    w1 = words [j];
                    w2 = words [i];
                }

                if (!strncmp (w1, w2, strlen (w2)) &&
                    !strncmp (w1 + strlen (w1) -
                                   strlen (w2), w2, strlen (w2))) {
                    count ++;
                }
            }
        }
        printf ("%d\n", count);
    }
    free (line);
    exit (0);
}
