# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char * ptr = line;
        int unsigned valid = 0;
        /*
         * Skip over the first word
         */
        while (* ptr && !isspace (* ptr)) {
            ptr ++;
        }

        while (* ptr && * ptr != '\n') {
            char * start;
            size_t w_len = 0;
            /*
             * Skip over whitespace
             */
            while (isspace (* ptr)) {
                ptr ++;
            }
            start = ptr;
            /*
             * Calculate the length of the prefix
             */
            while (!isspace (* ptr)) {
                ptr ++;
                w_len ++;
            }
            /*
             * If it's a prefix, increment the number of valids.
             * Special case the "", which indicates an empty string
             */
            if (!strncmp (line, start, w_len) ||
                 w_len == 2 && !strncmp (start, "\"\"", 2)) {
                valid ++;
            }
        }
        printf ("%d\n", valid);
    }
    exit (0);
}
