# include <stdlib.h>
# include <stdio.h>
# include <string.h>

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;

    while (getline (&line, &len, stdin) != -1) {
        char * line_ptr = line;

        while (*line_ptr) {
            switch (*line_ptr) {
                /* Replace the characters */
                case 'A': *line_ptr = 'T'; break;
                case 'T': *line_ptr = 'A'; break;
                case 'C': *line_ptr = 'G'; break;
                case 'G': *line_ptr = 'C'; break;
                /* We don't want to count the newline */
                default:  *line_ptr =  0;  break;
            }
            line_ptr ++;
        }
        printf ("%lu\n%s\n", strlen (line), line);
    }
    free (line);

    return (0);
}
