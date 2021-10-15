# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o
 */

# define SIZE 5

short tail [] = {789, 798, 879, 897, 978};

int main (void) {
    for (size_t i = 0; i < SIZE; i ++) {
        printf ("1023456%d\n", tail [i]);
    }
    return (0);
}
