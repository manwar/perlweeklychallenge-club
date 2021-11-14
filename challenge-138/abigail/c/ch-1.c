# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

# define SUNDAY    0
# define MONDAY    1
# define TUESDAY   2
# define WEDNESDAY 3
# define THURSDAY  4
# define FRIDAY    5
# define SATURDAY  6

int lookup  [] = {261, 261, 260, 260, 261, 261, 261,
                  262, 262, 261, 260, 261, 262, 262};
int anchors [] = {TUESDAY, SUNDAY, FRIDAY, WEDNESDAY};

int doomsday (int year) {
    int anchor = anchors [(year / 100) % 4];
    int y      = year % 100;
    return (((y / 12) + (y % 12) + ((y % 12) / 4)) + anchor) % 7;
}

int is_leap (int year) {
    return (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0)) ? 1 : 0;
}

int main (void) {
    int year;

    while (scanf ("%d", &year) == 1) {
        printf ("%d\n", lookup [is_leap (year) * 7 + doomsday (year)]);
    }

    return (0);
}
