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

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        str_len --;   /* Don't care about newline. */
        /*
         * Do we have just 9s?
         */
        bool all_nines = true;
        for (size_t i = 0; i < str_len; i ++) {
            if (line [i] != '9') {
                all_nines = false;
                break;
            }
        }
        if (all_nines) {
            printf ("1");
            for (size_t i = 0; i < str_len - 1; i ++) {
                printf ("0");
            }
            printf ("1\n");
            continue;
        }

        /*
         * Single character?
         */
        if (str_len == 1) {
            line [0] ++;
            printf ("%s", line);
            continue;
        }

        size_t mid = str_len / 2;

        /*
         * Is the first part reversed greater than the last part?
         */
        bool is_greater = false;
        ssize_t i;
        size_t j;
        for (i = mid - 1, j = mid + (str_len & 1); i >= 0; i --, j ++) {
            if (line [i] > line [j]) {
                is_greater = true;
                break;
            }
            if (line [i] < line [j]) {
                break;
            }
        }
        /*
         * If not greater, we need to add one of the first part (including
         * the middle part). We do this by starting from the middle, turning
         * 9s into 0s, and adding 1 to something not a 9. In the latter
         * case, we terminate the loop.
         */
        if (!is_greater) {
            for (i = mid - 1 + (str_len & 1); i >= 0; i --) {
                if (line [i] == '9') {
                    line [i] = '0';
                }
                else {
                    line [i] ++;
                    break;
                }
            }
        }

        /*
         * Now, copy the first half to the second; reversed
         */
        for (i = mid - 1, j = mid + (str_len & 1); i >= 0; i --, j ++) {
            line [j] = line [i];
        }

        printf ("%s", line);
    }
    free (line);

    return (0);
}
