# include <stdlib.h>
# include <stdio.h>
# include <string.h>

# define  NUL '\0'

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char * str  = NULL;  /* Input 1 */
        int size;            /* Input 2 */
        char filler;         /* Input 3 */

        char ** out = NULL;  /* Output array */
        
        /*
         * Initialize str. It cannot be longer than the line we just
         * read, so mallocing a string of that size will be enough.
         */
        if ((str = (char *) malloc (linelen * sizeof (char))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }

        /*
         * Parse the input. 
         */
        sscanf (line, "%s %d %c", str, &size, &filler);

        /*
         * Find out how many substrings we need.
         */
        size_t str_len = strlen (str);
        size_t out_len = str_len / size + (str_len % size ? 1 : 0);

        /*
         * Initialize the output array.
         */
        if ((out = (char **) malloc (out_len * sizeof (char *))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        /*
         * Allocate space for each substring. Set the trailing NUL characters
         */
        for (size_t i = 0; i < out_len; i ++) {
            if ((out [i] = (char *)
                            malloc ((size + 1) * sizeof (char))) == NULL) {
                perror ("Malloc failed");
                exit (1);
            }
            out [i] [size] = NUL;
        }
        /*
         * Fill the last substring with the filler character. First character
         * of the last string won't need the filler character. Some characters
         * may be overriden later
         */
        for (size_t i = 1; i < size; i ++) {
            out [out_len - 1] [i] = filler;
        }

        /*
         * Copy the characters from str to the substrings
         */
        for (size_t i = 0; i < str_len; i ++) {
            out [i / size] [i % size] = str [i];
        }

        /*
         * Print out the substrings. Follow them with a space, except
         * the last one -- which gets a trailing newline
         */
        for (size_t i = 0; i < out_len; i ++) {
            printf ("%s%c", out [i], i == out_len - 1 ? '\n' : ' ');
        }

        /*
         * Clean up
         */
        for (size_t i = 0; i < out_len; i ++) {
            free (out [i]);
        }
        free (out);
    }
    free (line);
    exit (0);
}
