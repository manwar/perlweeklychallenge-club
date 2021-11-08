# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    int num;

    while (scanf ("%d", &num) == 1) {
        printf ("%d\n", (num & 0x55) << 1
                      | (num & 0xAA) >> 1);
    }

    return (0);
}
