# include <stdlib.h>
# include <stdio.h>
# include <string.h>

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  strlen;

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        size_t e_count  = 0;
        while (* line_ptr) {
            if (* line_ptr == 'e') {
                * line_ptr = 'E';
                e_count ++;
            }
            line_ptr ++;
        }
        printf ("%s%zu\n", line, e_count);
    }
    free (line);

    return (0);
}
