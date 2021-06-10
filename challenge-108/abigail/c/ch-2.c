# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o
 */

# define COUNT   10

# define PLAIN    0
# define COMPUTE  2

typedef int number;  /* Change if we want large numbers */
char * fmt = "%d";   /* Should match typedef            */

int main (int argc, char * argv []) {
    int type = PLAIN;
    if (argc > 1) {
        if (strncmp (argv [1], "compute", 8) == 0) {
            type = COMPUTE;
        }
    }

    if (type == PLAIN) {
        printf ("1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147\n");
    }
    if (type == COMPUTE) {
        /*
         * Calculate the Bell triangle
         */
        number ** bell;
        if ((bell = (number **) malloc ((COUNT - 1) * sizeof (number *)))
            == NULL) {
             perror ("Mallocing bell failed");
             exit (1);
        }
        if ((bell [0] = (number *) malloc (sizeof (number))) == NULL) {
            perror ("Mallocing row failed");
            exit (1);
        }
        bell [0] [0] = 1;
        for (int x = 1; x < COUNT - 1; x ++) {
            if ((bell [x] = (number *) malloc ((x + 1) * sizeof (number)))
                == NULL) {
                perror ("Mallocing row failed");
                exit (1);
            }
            bell [x] [0] = bell [x - 1] [x - 1];
            for (int y = 1; y <= x; y ++) {
                bell [x] [y] = bell [x] [y - 1] + bell [x - 1] [y - 1];
            }
        }

        /*
         * Print the right diagonal
         */
        printf (fmt, 1);
        for (int x = 0; x < COUNT - 1; x ++) {
            printf (", ");
            printf (fmt, bell [x] [x]);
        }
        printf ("\n");
    }
    exit (0);
}
