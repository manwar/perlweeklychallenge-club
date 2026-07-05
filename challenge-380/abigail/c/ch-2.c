# include <stdlib.h>
# include <stdio.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int sum = 0;
        for (int i = 0; i < linelen; i ++) {
            char ch = line [i];
            if ('a' <= ch && ch <= 'z') {
                sum += (i + 1) * ('z' - ch + 1);
            }
        }
        printf ("%d\n", sum);
    }
    exit (0);
}
