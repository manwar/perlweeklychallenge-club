# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        /* First, replace anything which isn't a number into a space */
        char * ptr = line;
        while (* ptr) {
            if (!isdigit (* ptr) && * ptr != '-') {
                * ptr = ' ';
            }
            ptr ++;
        }
        int r1, r2, i1, i2;
        if (sscanf (line, "%d %d %d %d", &r1, &i1, &r2, &i2) != 4) {
            perror ("Failed to parse input");
            exit (1);
        }

        int r = r1 * r2 - i1 * i2;
        int i = r1 * i2 + r2 * i1;

        printf ("%d+%s%d%si\n", r, i < 0 ? "(" : "", i, i < 0 ? ")" : "");
    }
    exit (0);
}
