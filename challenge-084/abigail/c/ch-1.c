# include <stdlib.h>
# include <stdio.h>
# include <errno.h>


int main (void) {
    char *line     = NULL;
    size_t len     = 0;
    ssize_t length = 0;
    long result;
    /*
     * Iterate over the input, reading one line at a time
     */
    while ((length = getline (&line, &len, stdin)) != -1) {
        /*
         * Chop off any newline
         */
        if (line [length - 1] == '\n') {
            line [length - 1] = '\0';
            length --;
        }
        /*
         * Reverse the digits; we need to skip any leading hyphen.
         */
        ssize_t i = 0;
        if (line [0] == '-') {
            i = 1;
        }
        ssize_t j = length - 1;
        for (;i < j; i ++, j --) {
            char t = line [i];
            line [i] = line [j];
            line [j] = t;
        }
        /*
         * Check whether the result fits in a 32-bit integer.
         * We first convert the string to a long. If we get
         * an overflow or underflow, we can't fit anyway.
         * Otherwise, we compare the result with the bounds.
         */
        errno  = 0;
        result = strtol (line, NULL, 10);
        if (errno == ERANGE || result > 2147483647 || result < -2147483648) {
            printf ("0\n");
        }
        else {
            printf ("%s\n", line);
        }
    }
    free (line);
}
