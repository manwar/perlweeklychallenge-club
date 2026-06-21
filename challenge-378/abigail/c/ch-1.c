# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char max = 0;
        char sec = 0;
        char * ptr = line;
        while (* ptr) {
            char ch = * ptr ++;
            if (isdigit (ch)) {
                if (max < ch)             {sec = max; max = ch;}
                if (max > ch && ch > sec) {sec = ch;}
            }
        }
        if (sec) {
            printf ("%c\n", sec);
        }
        else {
            printf ("-1\n");
        }
    }
    free (line);
    exit (0);
}
