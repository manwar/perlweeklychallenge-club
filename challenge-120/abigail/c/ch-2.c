# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

# define DIFF_PER_MINUTE  11   /* Half degrees */
# define MIN_PER_HOUR     60
# define FULL_CIRCLE     720   /* Half degrees */

int main (void) {
    int hours, minutes;

    while (scanf ("%d:%d", &hours, &minutes) == 2) {
        int angle = (DIFF_PER_MINUTE * (hours * MIN_PER_HOUR + minutes)) %
                                                FULL_CIRCLE;
        if (2 * angle >= FULL_CIRCLE) {
            angle = FULL_CIRCLE - angle;
        }
        printf ("%d", angle / 2);
        if (angle % 2) {
            printf (".5");
        }
        printf ("\n");
    }
    return (0);
}
