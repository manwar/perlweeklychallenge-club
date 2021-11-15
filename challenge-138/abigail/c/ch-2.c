# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

bool can_split (long long target, long long number) {
    if (target >  number || target < 0) {return false;}
    if (target == number)               {return true;}

    long long pow_10 = 10;

    while (pow_10 <= number) {
        if (can_split (target - (number % pow_10), number / pow_10)) {
            return true;
        }
        pow_10 *= 10;
    }

    return false;
}

int main (void) {
    long long number;

    while (scanf ("%lld", &number) == 1) {
        printf ("%d\n", number > 1 &&
                        can_split ((long long) sqrt (number), number) ? 1 : 0);
    }
    return (0);
}
