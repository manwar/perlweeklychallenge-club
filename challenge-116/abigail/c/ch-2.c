# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        long sum_of_squares = 0;
        while (* line_ptr) {
            if (isdigit (* line_ptr)) {
                sum_of_squares += (* line_ptr - '0') * (* line_ptr - '0');
            }
            line_ptr ++;
        }
        long root = (long) floor (.5 + sqrt (sum_of_squares));
        printf ("%d\n", sum_of_squares == root * root ? 1 : 0);
    }
    free (line);

    return (0);
}
