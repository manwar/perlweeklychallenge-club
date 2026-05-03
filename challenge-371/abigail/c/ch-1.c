# include <stdlib.h>
# include <stdio.h>

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        for (ssize_t i = 0; i <= 8; i += 2) {
            if (line [i] == '?') {
                char base = line [i <= 4 ? i + 2 :                  i - 2];
                char from = line [i <  4 ? i + 6 : i == 4 ? i - 2 : i - 6];
                char to   = line [i <  4 ? i + 4 :                  i - 4];
                printf ("%c\n", base - from + to);
                break;
            }
        }
    }
    exit (0);
}
