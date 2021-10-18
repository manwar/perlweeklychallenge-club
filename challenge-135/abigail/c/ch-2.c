# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

short w [] = {1, 3, 1, 7, 3, 9, 1};

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        short valid = 1;
        if (str_len == 8) {
            int check = 0;
            for (size_t i = 0; i < 7 && valid; i ++) {
                char first;
                int  base;
                if ('0' <= line_ptr [i] && line_ptr [i] <= '9') {
                    first = '0';
                    base  =  0;
                }
                else {
                    if ('B' <= line_ptr [i] && line_ptr [i] <= 'Z' &&
                               line_ptr [i] != 'E'                 &&
                               line_ptr [i] != 'I'                 &&
                               line_ptr [i] != 'O'                 &&
                               line_ptr [i] != 'U') {
                        first = 'A';
                        base  = 10;
                    }
                    else {
                        valid = 0;
                    }
                }
                check += (line_ptr [i] - first + base) * w [i];
            }
            if (check % 10 != 0) {
                valid = 0;
            }
        }
        else {
            valid = 0;
        }
        printf ("%d\n", valid);
    }
    free (line);

    return (0);
}
