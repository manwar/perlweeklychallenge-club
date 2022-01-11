# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o
 */
# define COUNT 20

bool is_prime (int n) {
    if (n % 2 == 0) {return n == 2;}
    for (int i = 3; i * i <= n; i += 2) {
        if (n % i == 0) {return false;}
    }
    return true;
}

int main (void) {
    int * todo;
    if ((todo = (int *) malloc (4 * sizeof (int))) == NULL) {
        perror ("Malloc failed");
        return (1);
    }
    todo [0]    = 2;
    todo [1]    = 3;
    todo [2]    = 5;
    todo [3]    = 7;
    size_t high = 4;

    for (size_t i = 0; i < high; i ++) {
        printf ("%d ", todo [i]);
    }

    int count = COUNT - high;

    int pow = 10;
    while (count > 0) {
        int * next;
        int next_high = 0;
        if ((next = (int *) malloc (9 * high * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            return (1);
        }
        for (int d = 1; d <= 9 && count > 0; d ++) {
            for (size_t i = 0; i < high && count > 0; i ++) {
                int candidate = d * pow + todo [i];
                if (is_prime (candidate)) {
                    next [next_high ++] = candidate;
                    printf ("%d ", candidate);
                    count --;
                }
            }
        }
        if (!next_high) {
            break;
        }
        free (todo);
        todo = next;
        high = next_high;
        pow *= 10;
    }
    free (todo);

    printf ("\n");
}
