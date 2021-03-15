# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <unistd.h>
# include <ctype.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o -s SIZE < input-file
 */

int main (int argc, char ** argv) {
    char *  line     = NULL;
    size_t  len      = 0;
    size_t  strlen;
    int     ch;
    int     size = -1;

    while ((ch = getopt (argc, argv, "s:")) != -1) {
        switch (ch) {
            case 's':
                size = atoi (optarg);
                break;
        }
    }
    if (size < 0) {
        fprintf (stderr, "Requires an -s SIZE parameter\n");
        exit (1);
    }

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        strlen --;                      /* We don't care about the newline */
        int sections = strlen / size; 
        int sum = 0;
        for (int i = 0; i < size; i ++) {
            int zeros = 0;
            for (int j = 0; j < sections; j ++) {
                int index = j * size + i;
                if (line [index] == '0') {
                    zeros ++;
                }
            }
            int ones = sections - zeros;
            sum += zeros < ones ? zeros : ones;
        }
        printf ("%d\n", sum);
    }
    free (line);
    return (0);
}
