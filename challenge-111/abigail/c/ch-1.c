# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

# define MATRIX_SIZE 5
# define NR_OF_ELEMENTS (MATRIX_SIZE * MATRIX_SIZE)

static int compare (const void *a, const void *b) {
    return * (int *) a - * (int *) b;
}

int main (void) {
    int * matrix;
    int   target;

    if ((matrix = (int *) malloc (NR_OF_ELEMENTS * sizeof (int))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }

    /*
     * Read in the matrix
     */
    for (int i = 0; i < NR_OF_ELEMENTS; i ++) {
        if (scanf ("%d", &matrix [i]) != 1) {
            perror ("Scanf failed");
            exit (1);
        }
    }

    /*
     * Read in the search data, and print 1/0 depending on whether
     * the read number is in the matrix or not.
     */
    while (scanf ("%d", &target) == 1) {
        printf ("%d\n", bsearch (&target, matrix, NR_OF_ELEMENTS,
                                  sizeof (int), compare) == NULL ? 0 : 1);
    }

    return (0);
}
