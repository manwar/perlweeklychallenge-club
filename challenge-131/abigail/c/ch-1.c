# include <stdlib.h>
# include <stdio.h>
# include <string.h>

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
        int num;
        int offset;
        int prev = 0;
        while (sscanf (line_ptr, "%d%n", &num, &offset) == 1) {
            printf ("%s%d", prev     == 0   ? ""
                          : prev + 1 == num ? " "
                          :                   "\n", num);
            prev = num;
            line_ptr += offset;
        }
        printf ("\n");
    }
    free (line);

    return (0);
}
