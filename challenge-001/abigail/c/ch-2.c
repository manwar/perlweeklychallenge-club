# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o cc-2.c; ./ch-2.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  strlen;

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        int max = atoi (line);
        for (int i = 1; i <= max; i ++) {
            if (i % 15 == 0) {printf ("%s\n", "fizzbuzz"); continue;}
            if (i %  5 == 0) {printf ("%s\n",     "buzz"); continue;}
            if (i %  3 == 0) {printf ("%s\n", "fizz");     continue;}
            printf ("%d\n", i);
        }
    }
    free (line);

    return (0);
}
