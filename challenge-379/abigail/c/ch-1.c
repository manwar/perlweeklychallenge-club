# include <stdlib.h>
# include <stdio.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        for (ssize_t i = 0, j = linelen - 2; i < j; i ++, j --) {
            char t   = line [i];
            line [i] = line [j];
            line [j] = t;
        }
        printf ("%s", line);
    }
    free (line);
    exit (0);
}
