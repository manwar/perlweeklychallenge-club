/*
 * Challenge
 *
 * You are given an array of integers @N and an integer $A.
 *
 * Write a script to find find if there exists a pair of elements in
 * the array whose difference is $A.
 *
 * Print 1 if exists otherwise 0.
 */

# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>
# include <math.h>

# define DEFAULT_BUF_SIZE  128
# define BUF_INCREMENT       1.25   /* Increment the buffer size by   *
                                     * a quarter each time we run out *
                                     * of memory space.               */
/*
 * Compare two integer values, returning -1, 0, 1 if the first
 * is smaller, equal, or larger than the second.
 */
int cmp (const void * a, const void * b) {
    long diff = * (long *) a - * (long *) b;
    return  diff < 0 ? -1
         :  diff > 0 ?  1
         :              0;
}

/*
 * Binary search: return true if target is in array,
 * with index i, min <= i < max.
 */
bool bin_search (long * array, long target, size_t min, size_t max) {
    size_t mid = (min + max) / 2;   /* In C, dividing integers yields an *
                                     * integer, so there is no need for  *
                                     * flooring.                         */

    return min >= max            ? false
         : array [mid] == target ? true
         : array [mid] >  target ?
                     bin_search (array, target, min,     mid)
         :           bin_search (array, target, mid + 1, max);
}


int main (void) {
    /* Arguments for getline () */
    char *  line    = NULL;
    size_t  len     = 0;

    /* We'll store the numbers in array, which we will reuse for each *
     * line we're processing. We also need to keep track of how much  *
     * memory we have allocated for the array.                        */
    long * array    = NULL;
    size_t buf_size = DEFAULT_BUF_SIZE;

    /* The target difference */
    long target;

    /* Give the array some starting memory to work with.              */
    if ((array = (long *) malloc (buf_size * sizeof (long))) == NULL) {
        fprintf (stderr, "Out of memory\n");
        return (1);
    }

    /*
     * Iterate over the input, reading one line at a time
     * Every odd line will be a sequence of integers, every
     * even line will be a single integer. We'll do processing
     * after each even line.
     */
    bool   is_even = true;
    size_t size    = 0;       /* Number of integers in array.     */
    while (getline (&line, &len, stdin) != -1) {
        int    offset;
        char * line_ptr = line;

        is_even = !is_even;

        if (!is_even) {
            size = 0;   /* Reset size of array */
            long input; /* Each long read from the line */

            /* Scan the line just read, one long at a time */
            while (sscanf (line_ptr, "%ld%n", &input, &offset) == 1) {
                line_ptr += offset;

                if (++ size >= buf_size) {
                    /* Get some more memory. */
                    buf_size = (size_t) floorf (buf_size * BUF_INCREMENT);
                    if ((array = (long *) realloc (array,
                                 buf_size * sizeof (long))) == NULL) {
                        fprintf (stderr, "Out of memory\n");
                        return (1);
                    }
                }

                /* Store it */
                array [size - 1] = input;
            }

            /* Quick sort to sort the array */
            qsort (array, size, sizeof (long), cmp);
        }
        else {
            char * endptr;
            target = labs (strtol (line, &endptr, 10));

            /*
             * Iterate over the array, and check whether further down
             * the array we find a number equal to target + array [i] --
             * if so, there is a pair whose difference is target.
             */
            bool winner = false;
            for (size_t i = 0; i < size && !winner; i ++) {
                winner = bin_search (array, target + array [i], i + 1, size);
            }
            printf ("%d\n", winner ? 1 : 0);
        }
    }
    free (line);
    free (array);
}
