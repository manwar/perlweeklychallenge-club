# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>
# include <ctype.h>

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
        unsigned long long result = 0;
        bool seen_one = false;
        while (* line_ptr) {
            if (isdigit (* line_ptr)) {
                result *= 9;
                if (seen_one) {result += 8;}
                else {
                    if (* line_ptr == '1') {seen_one = true;}
                    else {
                        if (* line_ptr != '0') {
                            result += * line_ptr - '1';
                        }
                    }
                }
            }
            line_ptr ++;
        }
        printf ("%llu\n", result);
    }
    free (line);

    return (0);
}
