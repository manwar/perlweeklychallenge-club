# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o [plain | compute]
 */

# define PLAIN    0
# define COMPUTE  1

# define COUNT   20

typedef int number;  /* Change if we want large numbers */
# define fmt "%d"

number divisor_sum (number n) {
    number sum = 0;
    for (number i = 2; i < n; i ++) {
        if (!(n % i)) {
            sum += i;
        }
    }
    return (sum);
}

int main (int argc, char * argv []) {
    int type = PLAIN;
    if (argc > 1) {
        if (strncmp (argv [1], "compute", 8) == 0) {
            type = COMPUTE;
        }
    }

    if (type == PLAIN) {
        printf ("0, 0, 0, 2, 0, 5, 0, 6, 3, 7, ");
        printf ("0, 15, 0, 9, 8, 14, 0, 20, 0, 21\n");
    }
    if (type == COMPUTE) {
        for (number i = 1; i <= COUNT; i ++) {
            if (i != 1) {
                printf (", ");
            }
            printf (fmt, divisor_sum (i));
        }
        printf ("\n");
    }
    exit (0);
}
