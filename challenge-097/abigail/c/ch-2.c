# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <unistd.h>
# include <ctype.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o -s SECTIONS < input-file
 */

int main (int argc, char ** argv) {
    char *  line     = NULL;
    size_t  len      = 0;
    size_t  strlen;
    int     ch;
    int     sections = -1;

    while ((ch = getopt (argc, argv, "s:")) != -1) {
        switch (ch) {
            case 's':
                sections = atoi (optarg);
                break;
        }
    }
    if (sections < 0) {
        fprintf (stderr, "Requires an -s SECTIONS parameter\n");
        exit (1);
    }

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        strlen --;                      /* We don't care about the newline */
        int s_len = strlen / sections;  /* Section length                  */
        int sum = 0;
        for (int i = 0; i < s_len; i ++) {
            int zeros = 0;
            for (int j = 0; j < sections; j ++) {
                int index = j * s_len + i;
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
