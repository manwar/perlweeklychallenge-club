# include <stdlib.h>
# include <stdio.h>
# include <string.h>


int main (void) {
    ssize_t length   = 0;     /* Length of the current line of input.   */
    char *line       = NULL;  /* Pointer to read line.                  */
    size_t len       = 0;     /* Size allocated by getline.             */
    size_t width     = 0;     /* Width of matrix.                       */
    size_t height    = 0;     /* Height of matrix.                      */
    char **matrix    = NULL;  /* Main datastructure.                    */
    size_t max_lines = 10;    /* Allocated size of matrix. If we have   */
                              /* more lines, we need to realloc matrix. */

    /*
     * Initialize the size of matrix to some value.
     */
    if ((matrix = (char **) malloc (max_lines * sizeof (char *))) == NULL) {
        fprintf (stderr, "Out of memory\n");
        return (1);
    }

    /*
     * Read the input, line by line. Store lines in matrix.
     * We want to make sure all lines are the same length.
     */
    while ((length = getline (&line, &len, stdin)) != -1) {
        if (width && width != length) {
            printf ("Not all lines are of equal length\n");
            return (1);
        }
        else {
            width = length;
        }

        /*
         * If we have used up all the memory allocated to matrix,
         * we give it 50% more.
         */
        if (height >= max_lines) {
            char ** tmp;
            max_lines += max_lines / 2;
            if ((tmp = (char **) realloc (matrix, (sizeof (char*)) * (max_lines)))
                         == NULL) {
                fprintf (stderr, "Out of memory\n");
                return (1);
            }
            matrix = tmp;
        }

        /*
         * Copy the line we just read into matrix
         */
        if ((matrix [height] = (char *) malloc ((sizeof (char)) * (length + 1)))
             == NULL) {
            fprintf (stderr, "Failed to allocate memory\n");
            return (1);
        }
        strlcpy (matrix [height ++], line, (size_t) length + 1);
    }

    /*
     * Now it's a matter of using a cubic algorithm checking for squares.
     * For each 0 <= x < height, 0 <= 2 * y < width, and each k > 0 such that
     * x + k < height, and 2 * (y + k) < width, check whether all of the
     * following are true:
     *
     *     matrix [x]     [2 *  y]      == '1'
     *     matrix [x + k] [2 *  y]      == '1'
     *     matrix [x]     [2 * (y + k)] == '1'
     *     matrix [x + k] [2 * (y + k)] == '1'
     *
     * We will count all such cases.
     */

    unsigned int count = 0;
    for (int x = 0; x < height; x ++) {
        for (int y = 0; y < width; y += 2) {
            if (matrix [x] [y] == '1') {
                for (int k = 1; x + k < height && y + 2 * k < width; k ++) {
                    if (matrix [x + k] [y]         == '1' &&
                        matrix [x]     [y + 2 * k] == '1' &&
                        matrix [x + k] [y + 2 * k] == '1') {
                        count ++;
                    }
                }
            }
        }
    }

    printf ("%d\n", count);
    return (0);
}
