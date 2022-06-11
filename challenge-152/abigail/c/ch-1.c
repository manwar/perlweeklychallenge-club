# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        int minsum = 0;
        int n      = 1;
        int m      = 1;
        int num;
        int skip;
        int min    = 0;
        while (sscanf (line_ptr, "%d%n", &num, &skip) == 1) {
            line_ptr += skip;
            if (n == m || num < min) {
                min = num;
            }
            if (!-- m) {
                minsum += min;
                m       = ++ n;
                min     = 0;
            }
        }
        printf ("%d\n", minsum);
    }
    free (line);

    return (0);
}
