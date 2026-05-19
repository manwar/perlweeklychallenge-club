# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int max = -1;
        for (int f = 0; f < linelen - 1; f ++) {     /* For each char, ...  */
            for (int l = linelen - 2; l > f; l --) { /* find matching char  */
                if (line [f] == line [l]) {          /* from the end        */
                    if (l - f - 1 > max) {           /* If larger distance, */
                        max = l - f - 1;             /* remember it.        */
                    }
                    break;
                }
            }
        }
        printf ("%d\n", max);
    }
    free (line);
    exit (0);
}
