# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char ** todo;
        if ((todo = (char **) malloc (sizeof (char *))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        line [linelen - 1] = ' '; /* Turn newline into space */
        int n = 0;
        todo [n ++] = line;
        for (int i = 0; i < n; i ++) {
            bool found_qm = false;
            for (int j = 0; j < linelen; j ++) {
                if (todo [i] [j] == '?') {
                    /*
                     * Found a question mark. Allocate room for two
                     * more strings pointers.
                     */
                    if ((todo = (char **) realloc (todo,
                                         (n + 2) * sizeof (char *))) == NULL) {
                        perror ("Realloc failed");
                        exit (1);
                    }
                    /*
                     * Duplicate the current string twice, replacing
                     * the found question mark with 0 / 1
                     */
                    for (char k = '0'; k <= '1'; k ++) {
                        /*
                         * Allocate memory for the two new strings.
                         */
                        if ((todo [n] = (char *)
                             malloc ((linelen + 1) * sizeof (char))) == NULL) {
                            perror ("Malloc failed");
                            exit (1);
                        }
                        /*
                         * Copy the current string, including the trailing
                         * NUL byte
                         */
                        char * ptr1 = todo [i];
                        char * ptr2 = todo [n];
                        while (* ptr1) {
                            * ptr2 ++ = * ptr1 ++;
                        }
                        * ptr2 = 0;

                        /*
                         * Replace the question mark with '0' or '1'
                         */
                        todo [n] [j] = k;
                        n ++;
                    }
                    found_qm = true;
                    break;
                }
            }
            if (!found_qm) {
                printf ("%s", todo [i]);
            }
        }
        printf ("\n");
        /*
         * Free memory. Note that todo [0] is just line, which isn't
         * malloced in the loop, so we cannot free it here
         */
        for (int i = 1; i < n; i ++) {
            free (todo [i]);
        }
        free (todo);
    }
    free (line);
    exit (0);
}
