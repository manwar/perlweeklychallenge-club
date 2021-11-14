# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int cmp (const void * a, const void * b) {
    return (* (int *) a - * (int *) b);
}

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        /*
         * First, get rid of ';', and count the number of integers.
         */
        char * line_ptr = line;
        size_t count = 1;
        while (* line_ptr) {
            if (* line_ptr == ';') {
                * line_ptr =  ' ';
            }
            if (line_ptr != line &&
                !isspace (* line_ptr) && isspace (* (line_ptr - 1))) {
                count ++;
            }
            line_ptr ++;
        }

        /*
         * Create an array of the input numbers 
         */
        int * numbers;
        if ((numbers = (int *) malloc (count * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        line_ptr = line;
        int i = 0;
        int skip;
        int number;
        while (sscanf (line_ptr, "%d%n", &number, &skip) == 1) {
            numbers [i ++] = number;
            line_ptr += skip;
        }

        qsort (numbers, i, sizeof (int), cmp);

        /*
         * Iterate through the array to see if a number duplicates
         */
        int out = 1;
        for (int j = 1; j < i; j ++) {
            if (numbers [j] == numbers [j - 1]) {
                out = 0;
                break;
            }
        }

        printf ("%d\n", out);
    }
    free (line);

    return (0);
}
