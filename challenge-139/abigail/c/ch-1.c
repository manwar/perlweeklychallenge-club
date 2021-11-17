# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        int offset = 0;
        int off;
        int prev, next;
        bool sorted = true;
        if (sscanf (line, "%d%n", &prev, &offset) != 1) {
            perror ("Failure to scan");
            exit (1);
        }
        while (sscanf (line + offset, "%d%n", &next, &off) == 1) {
            offset += off;
            if (prev > next) {
                sorted = false;
            }
            prev = next;
        }
        printf ("%d\n", sorted ? 1 : 0);
    }
    free (line);

    return (0);
}
