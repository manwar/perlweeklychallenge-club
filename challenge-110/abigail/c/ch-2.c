# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    char *  text = NULL;
    size_t  len  = 0;
    size_t  str_len;

    if ((str_len = getdelim (&text, &len, '\0', stdin)) == -1) {
        perror ("Failed to read stdin");
        exit (1);
    }
    /*
     * Count the number of input lines and columns.
     */
    size_t nr_of_lines   = 0;
    size_t nr_of_columns = 0;
    char * ptr = text;
    while (* ptr) {
        if (nr_of_lines == 0) {
            if (* ptr == ',' || * ptr == '\n') {
                nr_of_columns ++;
            }
        }
        if (* ptr ++ == '\n') {
            nr_of_lines ++;
        }
    }

    /*
     * Position pointer at the start of each input line;
     * turn newlines into commas.
     */
    char ** outputs;
    if ((outputs = (char **) malloc (nr_of_lines * sizeof (char *)))
        == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    ptr = text;
    size_t c = 0;
    outputs [0] = ptr;
    while (* ptr) {
        if (* ptr == '\n') {
            * ptr = ',';
            if (* (ptr + 1) != '\0') {
                outputs [++ c] = ptr + 1;
            }
        }
        ptr ++;
    }

    /*
     * For each line of output, print a column of input.
     * Field are terminated by commas. For the output, proceed
     * each field with a comma, except for the first output column.
     */
    for (size_t i = 0; i < nr_of_columns; i ++) {
        for (size_t j = 0; j < nr_of_lines; j ++) {
            if (j) {
                printf (",");
            }
            while (* outputs [j] != ',') {
                printf ("%c", * outputs [j] ++);
            }
            outputs [j] ++;
        }
        printf ("\n");
    }

    free (text);
    return (0);
}
