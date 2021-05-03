# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    char *  raw     = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&raw, &len, stdin)) != -1) {
        /*
         * Make a copy of line, but without the spaces
         */
        char * line;
        if ((line = (char *) malloc ((str_len + 2) * sizeof (char))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        char * raw_ptr  = raw;
        char * line_ptr = line;
        while (* raw_ptr) {
            /*
             * Skip white space
             */
            if (isspace (* raw_ptr)) {
                raw_ptr ++;
                continue;
            }

            /*
             * If the first character is a '+', write two 0s.
             */
            if (line_ptr == line && * raw_ptr == '+') {
                * line_ptr ++ = '0';
                * line_ptr ++ = '0';
                raw_ptr ++;
                continue;
            }
            * line_ptr ++ = * raw_ptr ++;
        }
        * line_ptr = '\0';
        /*
         * If the first character is a '(', and the fourth is a ')',
         * replace both of them with 0
         */
        if (line [0] == '(' && line [3] == ')') {
            line [0] = '0';
            line [3] = '0';
        }

        /*
         * Check that we have exactly 14 digits
         */
        bool valid = true;
        for (size_t i = 0; i < 14 && valid; i ++) {
            if (!isdigit (line [i])) {
                valid = false;
            }
        }
        if (valid && line [14] == '\0') {
            printf ("%s", raw);
        }

        free (line);
    }
    free (raw);

    return (0);
}
