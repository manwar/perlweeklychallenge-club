# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>
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
        bool done = false;
        if (* line_ptr == '-' || * line_ptr == '+') {
            str_len --;
            line_ptr ++;
            while (isspace (* line_ptr)) {
                line_ptr ++;
                str_len --;
            }
        }
        /*
         * Is it an integer?
         */
        char * line_ptr2 = line_ptr;
        while (* line_ptr2 && * line_ptr2 != '\n') {
            if (!isdigit (* line_ptr2)) {
                printf ("not an integer\n");
                done = true;
                break;
            }
            line_ptr2 ++;
        }
        if (done) {
            continue;
        }

        /*
         * Is the length odd? (Note the string itself still contains a newline)
         */
        if (str_len % 2 == 1) {
            printf ("even number of digits\n");
            continue;
        }

        /*
         * Long enough?
         */
        if (str_len < 4) {
            printf ("too short\n");
            continue;
        }

        size_t mid = (str_len - 3) / 2;
        for (size_t i = 0; i < 3; i ++) {
            printf ("%c", line_ptr [mid + i]);
        }
        printf ("\n");
    }
    free (line);

    return (0);
}
