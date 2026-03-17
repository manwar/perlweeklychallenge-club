# include <stdlib.h>
# include <stdio.h>

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        for (int i = 0; i < linelen; i ++) {
            /*
             * Is is NN#, with 10 <= NN <= 26?
             */
            if (i + 2 < linecap     &&
                line [i + 2] == '#' &&
                (line [i] == '1' && line [i + 1] >= '0' &&
                                    line [i + 1] <= '9'    ||
                 line [i] == '2' && line [i + 1] >= '0' &&
                                    line [i + 1] <= '6')) {
                printf ("%c", 'a' + (line [i] == '1' ? 10 : 20)
                                  +  line [i + 1] - '0' - 1);
                i += 2;
                continue;
            }
            /*
             * Is this 1 <= N <= 9?
             */
            if (line [i] >= '1' && line [i] <= '9') {
                printf ("%c", 'a' + line [i] - '0' - 1);
                continue;
            }
            /*
             * Anything else is printed as is
             */
            printf ("%c", line [i]);
        }
    }
    free (line);
    exit (0);
}
