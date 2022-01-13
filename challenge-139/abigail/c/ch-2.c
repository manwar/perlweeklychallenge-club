# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

# define BASE         10
# define COUNT         5


bool is_long (int number) {
    int rest = 0;
    bool * seen;
    if ((seen = (bool *) malloc (number * sizeof (bool))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    for (size_t i = 0; i < number; i ++) {
        seen [i] = false;
    }
    for (int i = 2; i <= number; i ++) {
        rest = (rest * BASE + BASE - 1) % number;
        if (seen [rest] ++) {
            free (seen);
            return (0);
        }
    }
    free (seen);
    return (1);
}


int main (void) {
    int count  = COUNT;
    int number = 1;
    while (count) {
        number ++;
        if (BASE % number == 0) {continue;}
        if (is_long (number)) {
            printf ("%d\n", number);
            count --;
        }
    }
    return (0);
}
