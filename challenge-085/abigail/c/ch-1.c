/*
 * Challenge
 *
 * You are given an array of real numbers greater than zero.
 *
 * Write a script to find if there exists a triplet (a,b,c) such
 * that 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
 */

/*
 * A naieve implementation would be to check each triplet of numbers.
 * That leads to a cubic algorithm.
 *
 * Better is to sort numbers, then for each pair of numbers check whether
 * there is a third so that the sum of the three is between 1 and 2.
 * If the array is sorted, we can find such a number in O (log N) time,
 * resulting in a O (N^2 log N) run time.
 *
 * Also, if we sort the array (let's call the array a), we can restrict
 * our search to triplets a [i], a [j], a[k], with i < j < k. That means,
 * we can stop looking for a k if a [i] + 2 * a [j] >= 2, or 3 * a [i] >= 2.
 */

# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>
# include <math.h>

# define MAX                 2
# define MIN                 1
# define DEFAULT_BUF_SIZE  128
# define BUF_INCREMENT       1.25   /* Increment the buffer size by   *
                                     * a quarter each time we run out *
                                     * of memory space.               */
# define NOT_FOUND          -1

/*
 * Compare two floating point values, returning -1, 0, 1 if the first
 * is smaller, equal, or larger than the second.
 */
int cmp (const void * a, const void * b) {
    float  diff = * (float *) a - * (float *) b;
    return diff < 0 ? -1
         : diff > 0 ?  1
         :             0;
}

/*
 * Find the index k the largest number in array which is smaller than target,
 * and where min <= k < max, or -1 if there is not such a number.
 * The numbers in array are sorted.
 */
ssize_t bin_search (float * array, float target, size_t min, size_t max) {
    size_t mid = (min + max) / 2;   /* In C, dividing integers yields an *
                                     * integer, so there is no need for  *
                                     * flooring.                         */

    return min >= max ||
           array [min] >= target ? NOT_FOUND
         : min == max - 1        ? min
         : array [mid] >= target ? bin_search (array, target, min, mid)
         :                         bin_search (array, target, mid, max);
}

int main (void) {
    /* Arguments for getline () */
    char *  line     = NULL;
    size_t  len      = 0;
    ssize_t length   = 0;

    /* We'll store the numbers in array, which we will reuse for each *
     * line we're processing. We also need to keep track of how much  *
     * memory we have allocated for the array.                        */
    float * array    = NULL;
    size_t  buf_size = DEFAULT_BUF_SIZE;

    /* Give the array some starting memory to work with.              */
    if ((array = (float *) malloc (buf_size * sizeof (float))) == NULL) {
        fprintf (stderr, "Out of memory\n");
        return (1);
    }

    /*
     * Iterate over the input, reading one line at a time
     */
    while ((length = getline (&line, &len, stdin)) != -1) {
        size_t  size     = 0;       /* Number of floats in array.     */
        int     offset;
        float   input;
        char *  line_ptr = line;

        /*
         * Read in floats. Note that we don't use use line to pass
         * into sscanf, as we modify the first argument in the loop
         * (so it always points the part of the string we haven't
         *  scanned yet). We want to keep the orginal return value
         * of getline(), so the memory it points at can be reused.
         */
        while (sscanf (line_ptr, "%f%n", &input, &offset) == 1) {
            line_ptr += offset;
            if (input >= MAX) { /* Not interested in values exceeding */
                break;          /* the maximum, as they can never be  */
            }                   /* part of a winning triple.          */

            if (++ size >= buf_size) {
                /* Get some more memory. */
                buf_size = (size_t) floorf (buf_size * BUF_INCREMENT);
                if ((array = (float *) realloc (array,
                             buf_size * sizeof (float))) == NULL) {
                    fprintf (stderr, "Out of memory\n");
                    return (1);
                }
            }

            /* Store it */
            array [size - 1] = input;
        }

        qsort (array, size, sizeof (float), cmp);

        /*
         * O (N^2 log N) algorithm to find a winning triple, that is, 
         * indices i < j < k such that 
         *
         *     MIN < array [i] + array [j] + array [k] < MAX
         *
         * We will iterate over all i, j, with i < j, and for each
         * such pair, use binary search to find whether there is a k.
         *
         * We can stop searching if we either have a winning triplet (duh), or
         * if 3 * array [i] >= MAX, since array [i] <= array [j] <= array [k].
         * For a given i, we can stop searching for a pair j, k when
         * array [i] + 2 * array [j] >= MAX, for the same reason.
         */
        bool winner = false;
        for (size_t i = 0; i < size &&
                          !winner   &&
                           3 * array [i] < MAX; i ++) {
            for (size_t j = i + 1; j < size &&
                                  !winner   &&
                                   array [i] + 2 * array [j] < MAX; j ++) {
                float   target = MAX - array [i] - array [j];
                ssize_t k      = bin_search (array, target, j + 1, size);
                if (k != NOT_FOUND) {
                    /*
                     * We have a value so that we do not exceed the
                     * maximum, but we still have to check we're past
                     * the minimum. Note that array [k] is the largest
                     * of such numbers (for given i and j), so if we're
                     * not past the minimum, there is no solution for
                     * the given i and j.
                     */
                    if (MIN < array [i] + array [j] + array [k]) {
                        winner = 1;
                    }
                }
            }
        }

        printf ("%d\n", winner);

    }
    free (line);
    free (array);
}
