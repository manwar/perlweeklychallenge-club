# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */
# define SUM_15 120

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;
    int     sum     = 0;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        sum += atol (line);
    }
    printf ("%d\n", SUM_15 - sum);
    free (line);

    return (0);
}
