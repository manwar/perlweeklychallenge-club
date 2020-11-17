# include <stdlib.h>
# include <stdio.h>
# include <math.h>

/*
 * https://perlweeklychallenge.org/blog/perl-weekly-challenge-087/#TASK1
 *
 * See the notes in the Perl solution: ../perl/ch-1.pl
 */


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

    size_t size = 0;       /* Number of integers in array.     */

    while (getline (&line, &len, stdin) != -1) {
        int    offset;
        char * line_ptr = line;
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

        /*
         * Remove duplicates
         */
        size_t i;
        size_t j;
        for (i = j = 1; i < size; i ++) {
            if (array [i] != array [j - 1]) {
                array [j ++] = array [i];
            }
        }
        size = j;

        size_t max_streak = 0;
        size_t max_index  = 0;
        size_t cur_streak = 0;

        /*
         * Iterate over the array, track streaks of increasing numbers.
         * Also track the longest streak, and the index of where the
         * longest streak ends. Note that we count starting from 0.
         */
        for (size_t i = 1; i < size; i ++) {
            if (array [i] == array [i - 1] + 1) {
                if (++ cur_streak > max_streak) {
                    max_streak = cur_streak;
                    max_index  = i;
                }
            }
            else {
                cur_streak = 0;
            }
        }

        if (max_streak == 0) {
            /* Empty array, *or* a maximum streak of single number */
            printf ("%d\n", 0);
        }
        else {
            for (size_t i = max_index - max_streak; i <= max_index; i ++) {
                printf ("%ld", array [i]);
                if (i < max_index) {
                    printf (", ");
                }
            }
            printf ("\n");
        }
    }
    free (line);
    free (array);
}
