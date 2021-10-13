# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <limits.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    int n, m;
    char * buffer;

    while (scanf ("%d%d", &n, &m) == 2) {
        int size = 1 + m * n / CHAR_BIT;
        /*
         * Allocate memory for our buffer
         */
        if ((buffer = (char *) malloc (size * sizeof (char))) == NULL) {
            perror ("Failed to malloc buffer");
            exit (1);
        }
        /*
         * Set all the bits to 0
         */
        for (int i = 0; i < size; i ++) {
            buffer [i] = (char) 0;
        }

        int count = 0;  /* Count the number of different products */

        for (int i = 1; i <= m; i ++) {
            for (int j = 1; j <= n; j ++) {
                int index = (i * j) / CHAR_BIT;
                int bit   = (i * j) % CHAR_BIT;
                if ((buffer [index] & (1 << bit)) == 0) {
                    count ++;
                    buffer [index] |= (1 << bit);
                }
            }
        }
        printf ("%d\n", count);
        free (buffer);
    }

    return (0);
}
