# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

size_t idx (size_t x, size_t y) {
    return (x * (x + 1)) / 2 + y;
}

int main (void) {
    long long number;
    long long * numbers = NULL;
    size_t nr_of_numbers = 0;

    while (scanf ("%lld ", &number) != EOF) {
        if ((numbers = (long long *)
                        realloc (numbers,
                        ++ nr_of_numbers * sizeof (long long *))) == NULL) {
            perror (NULL);
            exit (1);
        }
        numbers [nr_of_numbers - 1] = number;
    }

    /*
     * Calculate the max row number from the max index
     */
    size_t max_row = (size_t) ((sqrt (9 + 8 * nr_of_numbers) - 3) / 2);


    /*
     * Calculate the minimum path bottom to top.
     */
    for (ssize_t x = max_row - 1; x >= 0; x --) {
        for (size_t y = 0; y <= x; y ++) {
            size_t idx1 = idx (x,     y);
            size_t idx2 = idx (x + 1, y);
            size_t idx3 = idx (x + 1, y + 1);
            numbers [idx1] += numbers [idx2] < numbers [idx3]
                            ? numbers [idx2] : numbers [idx3];
        }
    }

    printf ("%lld\n", numbers [0]);
}
