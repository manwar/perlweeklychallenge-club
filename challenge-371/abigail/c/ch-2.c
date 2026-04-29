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

            printf ("Parsed %d\n", numbers [count - 1]);

            /*
             * Skip over the number, including leading white space
             */
            while (* ptr &&  isspace (* ptr)) {ptr ++;}
            while (* ptr && !isspace (* ptr)) {ptr ++;}
        }

        for (int i = 1; i < pow (2, count) - 1; i ++) {
            printf ("i = %d\n", i);
        }
    }
    exit (0);
}
