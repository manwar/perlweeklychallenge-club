# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <unistd.h>
# include <ctype.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o -s SHIFT < input-file
 */

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  strlen;
    int     ch;
    int     shift   = -1;
    int     NR_OF_LETTERS = 26;

    while ((ch = getopt (argc, argv, "s:")) != -1) {
        switch (ch) {
            case 's':
                shift = atoi (optarg) % NR_OF_LETTERS;
                break;
        }
    }
    if (shift < 0) {
        fprintf (stderr, "Requires an -s parameter\n");
        exit (1);
    }

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        while (* line_ptr) {
            if (isupper (* line_ptr)) {
                * line_ptr -= shift;
                if (* line_ptr < 'A') {
                    * line_ptr += NR_OF_LETTERS;
                }
            }
            line_ptr ++;
        }
        printf ("%s", line);
    }
    free (line);
    return (0);
}
