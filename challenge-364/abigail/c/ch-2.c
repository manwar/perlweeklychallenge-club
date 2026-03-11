# include <stdlib.h>
# include <stdio.h>

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        for (int i = 0; i < linelen; i ++) {
            if (line [i] == '(') {
                /*
                 * Is it '(al)'?
                 */
                if (i + 3 < linecap &&
                    line [i + 1] == 'a' &&
                    line [i + 2] == 'l' &&
                    line [i + 3] == ')') {
                    printf ("al");
                    i += 3;
                    continue;
                }
                /*
                 * Is it '()'?
                 */
                if (i + 1 < linecap &&
                    line [i + 1] == ')') {
                    printf ("o");
                    i ++;
                    continue;
                }
            }
            /*
             * Otherwise, just print the character
             */
            printf ("%c", line [i]);
        }
    }
    free (line);
    exit (0);
}
