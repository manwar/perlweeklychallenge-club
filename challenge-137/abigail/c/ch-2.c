# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

long reverse (long number) {    
    long reverse = 0;
    while (number > 0) {
        reverse *= 10;
        reverse += number % 10;
        number  /= 10;
    }
    return reverse;
}

short ly (long n) {
    return n >= 10000000    ? 1
         : n == reverse (n) ? 0
         : ly (n + reverse (n));
}

int main (void) {
    long n;

    while (scanf ("%ld", &n) == 1) {
        printf ("%d\n", ly (n));
    }

    return (0);
}
