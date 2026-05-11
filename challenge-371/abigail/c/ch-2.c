# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>
# include <math.h>

# define NUL '\0'

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        /*
         * Count the number of numbers on the line.
         */
        int count = 0;
        int * numbers = NULL;
        if ((numbers = (int *) malloc (0 * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        line [linelen -- - 1] = NUL;

        char * ptr = line;
        while (* ptr) {
            if ((numbers = (int *) realloc (numbers,
                    (count + 1) * sizeof (int))) == NULL) {
                perror ("Malloc failed");
                exit (1);
            }
            numbers [count ++] = atoi (ptr);

            /*
             * Skip over the number, including leading white space
             */
            while (* ptr &&  isspace (* ptr)) {ptr ++;}
            while (* ptr && !isspace (* ptr)) {ptr ++;}
        }

        /*
         * Allocate room for the set. Note that we can, and will, reuse
         * the set. 
         */
        int * set;
        if ((set = (int *) malloc (count * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }

        for (int mask = 1; mask < pow (2, count) - 1; mask ++) {
            int sum       = 0;
            int set_count = 0;
            for (int index = 0; index < count; index ++) {
                if (mask & (1 << index)) {
                    set [set_count ++] = numbers [index];
                    sum += numbers [index] - index - 1;
                }
            }
            if (sum == 0 && set_count > 1) {
                for (int i = 0; i < set_count; i ++) {
                    printf ("%d%s", set [i], i == set_count - 1 ? "; " : " ");
                }
            }
        }
        printf ("\n");
        free (set);
    }
    free (line);
    exit (0);
}
