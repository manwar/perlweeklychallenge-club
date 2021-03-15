# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>
# include <math.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

# define RIGHT  0
# define UP     1
# define LEFT   2
# define DOWN   3

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  line_len;

    while ((line_len = getline (&line, &len, stdin)) != -1) {
        /*
         * Count the number of elements, so we know how much to allocate.
         */
        size_t count = 0;
        for (size_t i = 1; i <= line_len; i ++) {
            if (isspace (line [i]) && !isspace (line [i - 1])) {
                count ++;
            }
        }
        /*
         * Allocate memory for elements
         */
        char ** elements;
        if ((elements = (char **) malloc (count * sizeof (char *))) == NULL) {
            perror ("Failed to malloc 'elements'");
            exit (1);
        }

        /*
         * Iterate over the string again; now find the beginning
         * of all the 'words', and allocate them to the elements
         * array; make every space a NUL character, so each element
         * is terminated.
         */
        size_t c = 0;
        for (size_t i = 0; i < line_len; i ++) {
            if (!isspace (line [i]) && (!i || !line [i - 1])) {
                elements [c ++] = line + i;
            }
            if (isspace (line [i])) {
                line [i] = '\0';
            }
        }

        /*
         * Determine the width and height of the resulting matrix
         */
        size_t height = (size_t) floor (sqrt (count));
        for (;count % height;) {
            height --;
        }
        size_t width = count / height;

        /*
         * Allocate memory for the resulting matrix
         */
        char *** matrix;
        if ((matrix = (char ***) malloc (height * sizeof (char **))) == NULL) {
            perror ("Failed to malloc 'matrix'");
            exit (1);
        }
        for (size_t x = 0; x < height; x ++) {
            if ((matrix [x] = (char **) malloc
                                       (width * sizeof (char *))) == NULL) {
                perror ("Failed to malloc row for 'matrix'");
                exit (1);
            }
        }

        /*
         * Fill the matrix, starting at the bottom left
         */
        short  direction = RIGHT;
        size_t min_x = 0;
        size_t max_x = height - 1;
        size_t min_y = 0;
        size_t max_y = width  - 1;
        size_t x = max_x;
        size_t y = min_y;
        for (size_t i = 0; i < count; i ++) {
            matrix [x] [y] = elements [i];
            bool turn = false;
            if (direction == RIGHT) {
                if   (y >= max_y) {turn = true; x --; max_x --;}
                else {y ++;}
            }
            if (direction == UP) {
                if   (x <= min_x) {turn = true; y --; max_y --;}
                else {x --;}
            }
            if (direction == LEFT) {
                if   (y <= min_y) {turn = true; x ++; min_x ++;}
                else {y --;}
            }
            if (direction == DOWN) {
                if   (x >= max_x) {turn = true; y ++; min_y ++;}
                else {x ++;}
            }
            if (turn) {
                direction ++;
                direction %= 4;
            }
        }

        /*
         * Determine the width of each column.
         */
        size_t * widths;
        if ((widths = (size_t *) malloc (width * sizeof (size_t))) == NULL) {
            perror ("Failed to malloc 'widths'");
            exit (1);
        }
        for (size_t y = 0; y < width; y ++) {
            size_t max = 0;
            for (size_t x = 0; x < height; x ++) {
                if (max < strlen (matrix [x] [y])) {
                    max = strlen (matrix [x] [y]);
                }
            }
            widths [y] = max;
        }

        /*
         * Print out the matrix
         */
        char format [15];  /* We can safely assume no element from the
                            * input is longer than 2^32 characters wide.
                            * (And (size_t) -1 on our box is 2^32 - 1 anyway.)
                            * '%s%Ws' is hence at most 15 characters, if
                            * W does not exceed 10 characters, and there is
                            * a terminating NUL character */
        for (size_t x = 0; x < height; x ++) {
            for (size_t y = 0; y < width; y ++) {
                sprintf (format, "%%s%%%zus", widths [y]);
                 printf (format, y ? " " : "", matrix [x] [y]);
            }
            printf ("\n");
        }

        /*
         * Free allocated memory
         */
        free (widths);
        for (size_t x = 0; x < height; x ++) {
            free (matrix [x]);
        }
        free (matrix);
        free (elements);
    }
    free (line);

    return (0);
}
