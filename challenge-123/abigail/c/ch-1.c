# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

typedef long long number;
int main (void) {
    int n;
    number * ugly = NULL;
    size_t count = 0;
    size_t next_2, next_3, next_5;


    while (scanf ("%d", &n) == 1) {
        if (n > count) {
            if ((ugly = (number *) realloc (ugly, n * sizeof (number)))
                == NULL) {
                perror ("Realloc failed");
                exit (1);
            }
        }
        if (count == 0) {
            ugly [0] = 1;
            count = 1;
            next_2 = next_3 = next_5 = 0;
        }
        while (count < n) {
            number c2 = 2 * ugly [next_2];
            number c3 = 3 * ugly [next_3];
            number c5 = 5 * ugly [next_5];
            
            ugly [count] = c2 < c3 ? c2 < c5 ? c2 : c5
                                   : c3 < c5 ? c3 : c5;

            if (2 * ugly [next_2] <= ugly [count]) {next_2 ++;}
            if (3 * ugly [next_3] <= ugly [count]) {next_3 ++;}
            if (5 * ugly [next_5] <= ugly [count]) {next_5 ++;}

            count ++;
        }
        printf ("%lld\n", ugly [n - 1]);
    }
    free (ugly);

    return (0);
}
