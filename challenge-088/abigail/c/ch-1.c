# include <stdlib.h>
# include <stdio.h>

/*
 * Challenge
 *
 * You are given an array of positive integers @N.
 *
 * Write a script to return an array @M where $M[i] is the product of
 * all elements of @N except the index $N[i].
 */

/*
 * We first calculate the result for M [0], by multiplying all
 * numbers N [1 ..]. Then, for each i > 0, we calculate M [i] as
 *
 *      M [i] = (M [i - 1] / N [i]) * N [i - 1]
 *
 * Assuming the challenge is created such that each M [i] fits in an
 * integer, this will not result in an overflow, as long as we first do
 * the division, then the multiplication.
 * Note that N [i] evenly divides M [i - 1] by definition.
 */


# define DEFAULT_BUF_SIZE 128

typedef long long number;

int main (void) {
    /* Arguments for getline () */
    char *  line    = NULL;
    size_t  len     = 0;

    /* We'll store the numbers in array, which we will reuse for each *
     * line we're processing. We also need to keep track of how much  *
     * memory we have allocated for the array.                        */
    number * array  = NULL;
    size_t buf_size = DEFAULT_BUF_SIZE;

    /* Give the array some starting memory to work with.              */
    if ((array = (number *) malloc (buf_size * sizeof (number))) == NULL) {
        fprintf (stderr, "Out of memory\n");
        return (1);
    }

    size_t size = 0;       /* Number of integers in array.     */

    while (getline (&line, &len, stdin) != -1) {
        int    offset;
        char * line_ptr = line;
        number input; /* Each number read from the line */

        size = 0;     /* Reset size of array */

        /* Scan the line just read, one number at a time */
        while (sscanf (line_ptr, "%lld%n", &input, &offset) == 1) {
            line_ptr += offset;

            if (++ size >= buf_size) {
                /* Get twice the amount of memory */
                buf_size = buf_size * 2;
                if ((array = (number *) realloc (array,
                             buf_size * sizeof (number))) == NULL) {
                    fprintf (stderr, "Out of memory\n");
                    return (1);
                }
            }

            /* Store it */
            array [size - 1] = input;
        }

        /*
         * Get the first product (M [0]), and print it.
         */
        number product = 1;
        for (size_t i = 1; i < size; i ++) {
            product = product * array [i];
        }

        printf ("%lld", product);

        /*
         * We can now calculate each next product by first
         * dividing by array [i], then multiplying by array [i - 1].
         */
        for (size_t i = 1; i < size; i ++) {
            product = product / array [i];
            product = product * array [i - 1];
            printf (", %lld", product);
        }

        printf ("\n");
    }
    free (line);
    free (array);
}
