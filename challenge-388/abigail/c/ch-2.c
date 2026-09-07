# include <stdlib.h>
# include <stdio.h>

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int n = atoi (line);
        int sf = 1;
        for (int i = 1; i <= n; i ++) {
            sf = i * sf + 1 - 2 * (i % 2);
        }
        printf ("%d\n", sf);
    }
    free (line);
    exit (0);
}
