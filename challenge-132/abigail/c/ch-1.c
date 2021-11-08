# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

# define idx_Y 0
# define idx_M 1
# define idx_D 2

typedef unsigned short date_type;

long g2j (date_type Y, date_type M, date_type D) {
    return ((1461 * (Y + 4800  +  (M - 14) / 12))  /   4   +
            (367 * (M - 2 - 12 * ((M - 14) / 12))) /  12   -
            (3 * ((Y + 4900    +  (M - 14) / 12)   / 100)) / 4 + D - 32075);
}

void j2g (long J, date_type * date) {
    long e = 4 * (J + 1401 + (((4 * J + 274277) / 146097) * 3) / 4 - 38) + 3;
    date [idx_D] =  ((5 * ((e % 1461) / 4) + 2) % 153) / 5 + 1;
    date [idx_M] = (((5 * ((e % 1461) / 4) + 2) / 153 + 2) % 12) + 1;
    date [idx_Y] =         (e / 1461) - 4716 + (12 + 2 - date [idx_M]) / 12;
}

unsigned short TODAY [] = {2021, 9, 22};

int main (void) {
    date_type Y, M, D;
    date_type * date_early;
    date_type * date_late;

    if ((date_early = (date_type *) malloc (3 * sizeof (date_type))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    if ((date_late  = (date_type *) malloc (3 * sizeof (date_type))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }

    long julian_today = g2j (TODAY [idx_Y], TODAY [idx_M], TODAY [idx_D]);

    while (scanf ("%hu/%hu/%hu", &Y, &M, &D) == 3) {
        long julian_then = g2j (Y, M, D);
        j2g (2 * julian_then  - julian_today, date_early);
        j2g (2 * julian_today - julian_then,  date_late);
        printf ("%04d/%02d/%02d, %04d/%02d/%02d\n",
                 date_early [idx_Y], date_early [idx_M], date_early [idx_D],
                 date_late  [idx_Y], date_late  [idx_M], date_late  [idx_D]);
    }
    free (date_early);
    free (date_late);

    return (0);
}
