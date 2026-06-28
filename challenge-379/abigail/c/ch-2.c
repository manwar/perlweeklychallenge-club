# include <stdlib.h>
# include <stdio.h>
# include <math.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int base;
        int limit;
        if (sscanf (line, "%d %d", &base, &limit) != 2) {
            fprintf (stderr, "Cannot parse '%s'\n", line);
            exit (1);
        }

        for (int n = 0; n <= limit; n ++) {
            int size = 0;
            for (int n_c = n; n_c; n_c /= base) {
                size ++;
            }
            long sum = 0;
            for (int n_c = n; n_c; n_c /= base) {
                sum += (long) pow (n_c % base, size);
            }
            if (sum == n) {
                printf ("%ld ", sum);
            }
        }
        printf ("\n");
    }
    exit (0);
}
