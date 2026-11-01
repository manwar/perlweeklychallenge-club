# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>
# include <stdbool.h>

# define NUL '\0'

/*
 * Call as:
 *   long * array;
 *   int count = array_of_long (line, &array)
 */

int array_of_long (char * line, long ** array) {
    /*
     * Count the number of integers in the string. We detect integers
     * by finding digits followed by a space, or a NUL
     */
    char * ptr = line;
    int count = 0;

    while (* ptr) {
        if (isdigit (* ptr) && (* (ptr + 1) == NUL || isspace (* (ptr + 1)))) {
            count ++;
        }
        ptr ++;
    } 

    /*
     * Allocate memory for the array now that we have the number of longs
     */
    if ((* array = (long *) malloc (count * sizeof (long))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }

    /*
     * Parse the line
     */
    ptr = line;
    for (int i = 0; i < count; i ++) {
        (* array) [i] = strtol (ptr, &ptr, 10);
    }

    return (count);
}

int comp (const void * a, const void * b) {
    long x = * (const long *) a;
    long y = * (const long *) b;

    return x < y ? -1 : x > y ? 1 : 0;
}


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        long * numbers;
        int count = array_of_long (line, &numbers);

        qsort (numbers, count, sizeof (long), comp);

        long sum = 0;
        for (int i = 0; i < count; i ++) {
            sum += numbers [i];
        }

        long res = sum <= 0 ? 1 : 1 + sum / count;

        for (int i = 0; i < count; i ++) {
            if (numbers [i] == res) {
                res ++;
            }
            if (numbers [i] >  res) {
                break;
            }
        }

        printf ("%ld\n", res);
    }
    exit (0);
}
