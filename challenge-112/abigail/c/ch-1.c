# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

/*
 * Here, we will "eliminate" parts (".", or ".." and its parent)
 * by replacing the parts with slashes. Then we print the string,
 * without printing 2 slashes in succession.
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        line [str_len - 1] = '/';
        for (size_t i = 0; i < str_len; i ++) {
            if (line [i] == '.' && line [i - 1] == '/') {
                /* Component starts with a . */
                if (line [i + 1] == '/') {
                    line [i] = '/';  /* Current directory */
                    continue;
                }
                else {
                    if (line [i + 1] == '.' && line [i + 2] == '/') {
                        /* Parent directory. */
                        /* First wipe this component */
                        line [i]     = '/';
                        line [i + 1] = '/';
                        /* Then wipe the previous component, if any. */
                        /* First, skip the slashes */
                        size_t j = i - 1;
                        while (j && line [j] == '/') {
                            j --;
                        }
                        /* Now, erase exactly one component */
                        while (j && line [j] != '/') {
                            line [j] = '/';
                            j --;
                        }
                    }
                }
            }
        }
        /* Get rid of trailing slashes */
        while (str_len > 1 && line [str_len - 1] == '/') {
            str_len --;
        }
        /* Print string, eliminating double slashes */
        bool slash = false;
        for (size_t i = 0; i < str_len; i ++) {
            if (line [i] == '/') {
                if (slash) {
                    continue;
                }
                slash = true;
            }
            else {
                slash = false;
            }
            printf ("%c", line [i]);
        }
        printf ("\n");
    }
    free (line);

    return (0);
}
