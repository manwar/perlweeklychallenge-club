# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>

# define NUL '\0'

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int n;
        size_t list_c = 0;
        char ** list = NULL;
        if ((list = (char **) malloc (list_c * sizeof (char *))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        n = atoi (line);
        /*
         * Skip over the first integer (n), and the whitespace
         */
        char * ptr = line;
        while (* ptr && !isspace (* ptr)) {ptr ++;}
        while (* ptr &&  isspace (* ptr)) {ptr ++;}

        /*
         * Parse the input line, setting pointers to the beginning
         * of each word in list
         */
        while (* ptr) {
            if ((list = (char **) realloc (list,
                                 (list_c + 1) * sizeof (char *))) == NULL) {
                perror ("Realloc failed");
                exit (1);
            }
            list [list_c ++] = ptr;
            /*
             * Skip to the next element, making spaces NUL
             */
            while (* ptr && !isspace (* ptr)) {  ptr ++;}
            while (* ptr &&  isspace (* ptr)) {* ptr ++ = NUL;}
        }

        /*
         * Special case if n exceeds the list size
         */
        if (n > list_c) {
            printf ("-1;\n");
            free (list);
            continue;
        }

        /*
         * Calculate the number of elements per set, and the number
         * of sets which get one more.
         */
        int per_set      = list_c / n;
        int overflow     = list_c - n * per_set;
        char ** list_ptr = list;

        /*
         * Print the sets
         */
        for (int i = 1; i <= n; i ++) {
            int set_size = per_set;  /* Calculate the  */
            if (i <= overflow) {     /* size of the    */
                set_size ++;         /* current set.   */
            }
            for (int j = 1; j <= set_size; j ++) {
                printf ("%s%s", * list_ptr ++, j == set_size ? "; " : " ");
            }
        }
        printf ("\n");

        free (list);    /* Clean up */
    }
    free (line);        /* Clean up */
    exit (0);
}
