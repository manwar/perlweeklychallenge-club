# include <stdlib.h>
# include <stdio.h>

/*
 * Challenge
 *
 * You are given m x n matrix of positive integers.
 * 
 * Write a script to print spiral matrix as list.
 */ 

/*
 * We solve this by keeping track of the boundaries (min_x, min_y, max_x,
 * max_y) of the part of the matrix which still needs to be processed.
 * Initially, min_x and min_y are 0, max_x is the index of the bottom row,
 * and max_y is the index of the right most column.
 *
 * We then process the matrix side by side, first going east (top row), 
 * south (left column), west (bottom row), then north (left row). After
 * doing a side, we update the corresponding min/max value. That is,
 * after doing the top row, we increment min_x; right column, decrement
 * max_y; bottom row, decrement max_x; left column, increment min_y.
 *
 * We're done when min_x > max_x, or min_y > max_y.
 */

typedef long long  number;
enum    dirs      {EAST, SOUTH, WEST, NORTH};

int main (void) {
    char *     text     = NULL; /* Complete input                     */
    size_t     buf_len  = 0;    /* Allocated buffer size              */
    ssize_t    str_len;         /* Number of characters read          */
    size_t     rows     = 0;    /* Number of rows in matrix           */
    size_t     columns  = 0;    /* Number of columns in matrix        */
    size_t     elements = 0;    /* Total number of elemenst in matrix */

    number     element;         /* Element read                       */
    int        offset;          /* Offset when scanning input         */
    char *     ptr;             /* Pointer into text                  */
    number **  matrix;          /* Matrix we're using                 */

    enum dirs  direction;       /* Direction of movement              */


    /* Read all the input (this assumes the input doesn't contain  *
     * a NUL character.                                            */
    str_len = getdelim (&text, &buf_len, 0, stdin);

    /* First, count the number of rows */
    ptr = text;
    while (*ptr) {
        if (*ptr == '\n') {
            rows ++;
        }
        ptr ++;
    }

    /* Count the number of elements */
    ptr = text;
    while (sscanf (ptr, "%lld%n", &element, &offset) == 1) {
        elements ++;
        ptr += offset;
    }

    /* We can now calculate the number of columns */
    columns = elements / rows;

    /* Check whether we have any elements left over; *
     * if so, we exit with an error.                 */
    if (elements != rows * columns) {
        fprintf (stderr, "That doesn't look like a proper matrix\n");
        exit (1);
    }

    /* Allocate memory */
    if ((matrix = (number **) calloc (rows, sizeof (number *))) == NULL) {
        fprintf (stderr, "Out of memory\n");
        exit (1);
    }

    for (size_t x = 0; x < rows; x ++) {
        if ((matrix [x] = (number *) calloc (columns,
                                             sizeof (number))) == NULL) {
            fprintf (stderr, "Out of memory\n");
            exit (1);
        }
    }

    /* Scan the text again, but now fill in the array */
    ptr = text;
    for (int x = 0; x < rows; x ++) {
        for (int y = 0; y < columns; y ++) {
            if (sscanf (ptr, "%lld%n", &matrix [x] [y], &offset) != 1) {
                fprintf (stderr, "Something really weird happened!\n");
                exit (1);
            }
            ptr += offset;
        }
    }

    /* Now it's time to do the real work */
    /* Note that we're using ssize_t for the min/max values; if we use  *
     * unsigned values, we're running into problems if we use a loop    *
     * counting down to zero. We would expect the loop to terminate if  *
     * the iterand is -1, but that cannot happen for an unsigned value. */
    ssize_t min_x = 0;
    ssize_t max_x = rows    - 1;
    ssize_t min_y = 0;
    ssize_t max_y = columns - 1;

    direction = EAST;   /* We start off heading East */

    size_t printed = 0; /* Each printed number will be preceeded by a  *
                         * comma, except the first.                    */
    while (min_x <= max_x && min_y <= max_y) {
        if (direction == EAST) {
            for (ssize_t y = min_y; y <= max_y; y ++) {
                printf (printed ++ ? ", %lld" : "%lld", matrix [min_x] [y]);
            }
            min_x ++;
        }
        if (direction == SOUTH) {
            for (ssize_t x = min_x; x <= max_x; x ++) {
                printf (", %lld", matrix [x] [max_y]);
            }
            max_y --;
        }
        if (direction == WEST) {
            for (ssize_t y = max_y; y >= min_y; y --) {
                printf (", %lld", matrix [max_x] [y]);
            }
            max_x --;
        }
        if (direction == NORTH) {
            for (ssize_t x = max_x; x >= min_x; x --) {
                printf (", %lld", matrix [x] [min_y]);
            }
            min_y ++;
        }
        direction = (direction + 1) % (NORTH + 1);
    }
    printf ("\n");
       
    /* Clean up the allocated memory */
    for (size_t x = 0; x < rows; x ++) {
        free (matrix [x]);
    }
    free (matrix);
    free (text);
}
