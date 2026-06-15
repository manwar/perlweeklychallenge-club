# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        bool matched = false;
        for (size_t i = 0; i < linelen - 1 && !matched; i ++) {
            for (size_t j = 0; j < linelen - 1 && !matched; j ++) {
                if (line [i] == line [j + 1] &&
                    line [j] == line [i + 1]) {
                    matched = true;
                }
            }
        }
        printf ("%s\n", matched ? "true" : "false");
    }
    exit (0);
}
