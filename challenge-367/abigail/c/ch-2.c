# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>

char tcmp (char unsigned t1 [2], char unsigned t2 [2]) {
    return t1 [0] < t2 [0] ? -1
         : t1 [0] > t2 [0] ?  1
         : t1 [1] < t2 [1] ? -1
         : t1 [1] > t2 [1] ?  1
         :                    0;
}


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char unsigned b1 [2];
        char unsigned e1 [2];
        char unsigned b2 [2];
        char unsigned e2 [2];
        if (sscanf (line, "%hhu:%hhu %hhu:%hhu %hhu:%hhu %hhu:%hhu",
                           &b1 [0], &b1 [1], &e1 [0], &e1 [1],
                           &b2 [0], &b2 [1], &e2 [0], &e2 [1]) != 8) {
            printf ("Failed to scan %s\n", line);
            exit (1);
        }

        bool straddle1 = tcmp (b1, e1) > 0;
        bool straddle2 = tcmp (b2, e2) > 0;

        if (straddle1 && straddle2) {
            printf ("true\n");
            continue;
        }

        if (straddle1) {
            printf ("%s\n", tcmp (b1, e2) >= 0 &&
                            tcmp (e1, b2) <= 0 ? "false" : "true");
            continue;
        }

        if (straddle2) {
            printf ("%s\n", tcmp (b2, e1) >= 0 &&
                            tcmp (e2, b1) <= 0 ? "false" : "true");
            continue;
        }

        printf ("%s\n", tcmp (e2, b1) <= 0 ||
                        tcmp (b2, e1) >= 0 ? "false" : "true");
    }

    exit (0);
}
