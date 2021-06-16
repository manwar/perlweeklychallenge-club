# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

void steps (int x, int y, char * path, size_t l) {
    if (x == 0 && y == 0) {
        printf ("%s\n", path);
        return;
    }
    if (x > 0) {
        path [l]     = 'R';
        path [l + 1] = '\0';
        steps (x - 1, y,     path, l + 1);
        path [l]     = 'L';
        path [l + 1] = '\0';
        steps (x - 1, y + 1, path, l + 1);
    }
    if (y > 0) {
        path [l]     = 'H';
        path [l + 1] = '\0';
        steps (x,     y - 1, path, l + 1);
    }
}

int main (void) {
    int size;
    if (scanf ("%d", &size) == 1) {
        char * path;
        if ((path = (char *) malloc ((size + 1) * sizeof (char))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        path [0] = '\0';
        steps (size, 0, path, 0);
    }
    return (0);
}
