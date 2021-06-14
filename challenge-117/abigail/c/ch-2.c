# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

void steps (int x, int y, char * prefix, size_t l) {
    if (x == 0 && y == 0) {
        printf ("%s\n", prefix);
        return;
    }
    if (x > 0) {
        prefix [l]     = 'R';
        prefix [l + 1] = '\0';
        steps (x - 1, y,     prefix, l + 1);
        prefix [l]     = 'L';
        prefix [l + 1] = '\0';
        steps (x - 1, y + 1, prefix, l + 1);
    }
    if (y > 0) {
        prefix [l]     = 'H';
        prefix [l + 1] = '\0';
        steps (x,     y - 1, prefix, l + 1);
    }
}

int main (void) {
    int size;
    if (scanf ("%d", &size) == 1) {
        char * prefix;
        if ((prefix = (char *) malloc ((size + 1) * sizeof (char))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        prefix [0] = '\0';
        steps (size, 0, prefix, 0);
    }
    return (0);
}
