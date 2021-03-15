# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

# define MAX_LENGTH 23

/*
 * We generate the string to be created backwards, using an
 * array 'out'. Here we store either a '-1' if the string needs
 * a hash in that position, or the index otherwise.
 * 
 * At the end, we print the pieces in reverse, mapping -1 to a hash.
 */

int main (void) {
    long long index;
    char tmp [MAX_LENGTH];

    while (scanf ("%lld", &index) > 0) {
        /*
         * Create an array of long longs. (More than we need).
         */
        long long * out;
        if ((out = (long long *) malloc (index * sizeof (long long))) == NULL) {
            perror ("Malloc 'out' failed");
            exit (1);
        }

        bool hash = false;
        size_t i = 0;

        while (index) {
            if ((hash = !hash)) {
                out [i] = -1;
                index --;
            }
            else {
                out [i] = index + 1;
                sprintf (tmp, "%lld", out [i]);
                index -= strnlen (tmp, MAX_LENGTH);
            }
            i ++;
        }
        for (;i --;) {
            if (out [i] == -1) {
                printf ("#");
            }
            else {
                printf ("%lld", out [i]);
            }
        }
        printf ("\n");

        free (out);
    }
    return (0);
}
