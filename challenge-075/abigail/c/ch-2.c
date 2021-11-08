# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        int height;
        int n;
        int offset = 0;
        int c = 0;
        while (sscanf (line + offset, "%d%n", &height, &n) == 1) {
            offset += n;
            c ++;
        }
        /*
         * Now c will be the amount of integers on the line.
         * We need this to determine the size of the to be
         * allocated array
         */
        int * heights;
        if ((heights = (int *) malloc (c * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        offset = 0;
        c = 0;
        int max_height = 0;
        while (sscanf (line + offset, "%d%n", &height, &n) == 1) {
            offset += n;
            heights [c ++] = height;
            if (max_height < height) {
                max_height = height;
            }
        }

        /*
         * For each height, find the longest sequence of consecutive
         * columns with at least that height, and calculate the
         * rectangle with that height. Remember the largest.
         */

        int max_area = 0;
        for (int h = 1; h <= max_height; h ++) {
            int cur = 0;
            int max = 0;
            for (int i = 0; i < c; i ++) {
                if (heights [i] >= h) {
                    cur ++;
                }
                else {
                    if (max < cur) {
                        max = cur;
                    }
                    cur = 0;
                }
            }
            if (max < cur) {
                max = cur;
            }

            int area = max * h;
            if (max_area < area) {
                max_area = area;
            }
        }

        printf ("%d\n", max_area);
    }
    free (line);

    return (0);
}
