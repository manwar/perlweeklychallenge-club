# include <stdlib.h>
# include <stdio.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        if (linelen != 6) {
            fprintf (stderr, "Cannot parse input\n");
            exit (1);
        }
        char f1 = line [0];
        char r1 = line [1];
        char sp = line [2];
        char f2 = line [3];
        char r2 = line [4];
        if (f1 < 'a' || f1 > 'h' || r1 < '1' || r1 > '8' ||
            f2 < 'a' || f2 > 'h' || r2 < '1' || r2 > '8' || sp != ' ') {
            fprintf (stderr, "Cannot parse input\n");
            exit (1);
        }
        printf ("%s\n",
               (((f1 % 2) == (r1 % 2) ? 1 : 0) +
                ((f2 % 2) == (r2 % 2) ? 1 : 0)) == 1 ? "false" : "true");
    }
    exit (0);
}
