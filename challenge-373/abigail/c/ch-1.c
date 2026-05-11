# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>

# define NUL '\0'

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        /*
         * Allocate space to split the input string into two
         */
        char * part0;
        char * part1;
        if ((part0 = (char *) malloc (linelen * sizeof (char))) == NULL) {
           perror ("Malloc failed");
           exit (1);
        }
        if ((part1 = (char *) malloc (linelen * sizeof (char))) == NULL) {
           perror ("Malloc failed");
           exit (1);
        }

        /*
         * Iterate over the input string
         */
        char * dest = part0;
        for (char * ptr = line; * ptr; ptr ++) {
           if (isspace (* ptr) || * ptr == '.') {    /* Skip spaces and dots */
               continue;
           }
           if (* ptr == ';') {                       /* Split on ;           */
               * dest = NUL;                         /* Terminate part 0     */
               dest = part1;                         /* Switch to part 1     */
               continue;
           }
           * dest ++ = * ptr;                        /* Copy character       */
        }
        * dest = NUL;                                /* Terminate part 1     */

        printf ("%s\n", strcmp (part0, part1) == 0   /* Equal?               */
                             ? "true" : "false");
    }
    free (line);
    exit (0);
}
