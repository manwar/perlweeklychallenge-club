# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o
 */

bool is_pentagonal (int candidate, int * pentagon, size_t max) {
    size_t low  = 0;
    size_t high = max;
    while (low < high) {
        size_t mid = (low + high) / 2;
        if (pentagon [mid] == candidate) {return true;}
        if (pentagon [mid]  < candidate) {low  = mid + 1;}
        if (pentagon [mid]  > candidate) {high = mid;}
    }
    return false;
}


int main (void) {
    int *  pentagon =  NULL;
    int    n        =     0;
    int    p        =     0;
    size_t cap      =   100;
    size_t high     =     0;
    bool   done     = false;

    if ((pentagon = (int *) malloc (cap * sizeof (int))) == NULL) {
        perror ("Malloc failed");
        return (1);
    }

    while (!done) {
        p += n + n + n + 1;
        n ++;
        if (high >= cap) {
            cap *= 2;
            if ((pentagon =
                     (int *) realloc (pentagon, cap * sizeof (int))) == NULL) {
                perror ("Realloc failed");
                return (1);
            }
        }
        pentagon [high ++] = p;

        for (size_t i = 0; i < high &&
                           pentagon [i] + pentagon [i] < p &&
                          !done; i ++) {
            int seen = pentagon [i];
            if (is_pentagonal (p - seen,        pentagon, high) &&
                is_pentagonal (p - seen - seen, pentagon, high)) {
                printf ("%d %d\n", seen, p - seen);
                done = true;
            }
        }
    }

    return (0);
}
