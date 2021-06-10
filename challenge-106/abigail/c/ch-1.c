# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

typedef long long number;
# define number_fmt "%lld"

/*
 * Given a string, extract the numbers, and put them into an
 * array. Return the number of extracted numbers.
 */
size_t extract_numbers (char * line, number ** list) {
    /*
     * First, calculate the number of numbers
     */
    char * ptr = line;    /* Copy of line, so we don't modify line */
    number num;           /* Number scanned                        */
    int n;                /* Number of characters scanned          */
    size_t c = 0;         /* Count of numbers scanned              */
    number * numbers;     /* List of numbers to be created         */

    while (sscanf (ptr, number_fmt "%n", &num, &n) == 1) {
        ptr += n;
        c ++;
    }

    /*
     * Allocate memory for the array to be returned
     */
    if ((numbers = (number *) malloc (c * sizeof (number))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }

    /*
     * Scan again, this time, populate the array.
     */
    ptr = line;
    c = 0;
    while (sscanf (ptr, number_fmt "%n", &num, &n) == 1) {
        ptr += n;
        numbers [c ++] = num;
    }
    * list = numbers;
    return (c);
}

/*
 * Compare two numbers, called from qsort
 */
int num_compare (const void * p1, const void * p2) {
    number n1 = * (const number *) p1;
    number n2 = * (const number *) p2;
    return n1 < n2 ? -1 : n1 > n2 ? 1 : 0;
}


int main (void) {
    char *  line  = NULL;
    size_t  len   = 0;
    size_t  str_len;

    /*
     * Read a line of input
     */
    while ((str_len = getline (&line, &len, stdin)) != -1) {
        /*
         * Extract the numbers from the line of input, putting
         * them in an array N; n will be the number of numbers in N.
         */
        number * N = NULL;
        size_t   n = extract_numbers (line, &N);

        /*
         * Sort the array.
         */
        qsort (N, n, sizeof (number), num_compare);

        /*
         * Find the maximum
         */
        number max = 0;
        for (size_t i = 1; i < n; i ++) {
            if (N [i] - N [i - 1] > max) {
                max = N [i] - N [i - 1];
            }
        }

        /*
         * Print it
         */
        printf (number_fmt "\n", max);

        /*
         * Free the used memory for the array of numbers.
         */
        free (N);
    }
    free (line);

    return (0);
}
