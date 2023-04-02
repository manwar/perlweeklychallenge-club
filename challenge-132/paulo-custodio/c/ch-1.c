/*
Challenge 132

TASK #1 > Mirror Dates
Submitted by: Mark Anderson
You are given a date (yyyy/mm/dd).

Assuming, the given date is your date of birth. Write a script to find the
mirror dates of the given date.

Dave Cross has built cool site that does something similar.

Assuming today is 2021/09/22.
Example 1:
Input: 2021/09/18
Output: 2021/09/14, 2021/09/26

On the date you were born, someone who was your current age, would have
been born on 2021/09/14.
Someone born today will be your current age on 2021/09/26.
Example 2:
Input: 1975/10/10
Output: 1929/10/27, 2067/09/05

On the date you were born, someone who was your current age, would have
been born on 1929/10/27.
Someone born today will be your current age on 2067/09/05.
Example 3:
Input: 1967/02/14
Output: 1912/07/08, 2076/04/30

On the date you were born, someone who was your current age, would have
been born on 1912/07/08.
Someone born today will be your current age on 2076/04/30.
*/

#include <stdio.h>
#include <stdlib.h>

// https://pdc.ro.nu/jd-code.html
long gregorian_date_to_jd(int y, int m, int d) {
    y += 8000;
    if (m < 3) { y--; m += 12; }
    return (y * 365) + (y / 4) - (y / 100) + (y / 400) - 1200820
        + (m * 153 + 3) / 5 - 92 + d - 1;
}

void jd_to_gregorian_date(long jd, int* yp, int* mp, int* dp) {
    int y, m, d;
    for (y = jd / 366 - 4715; gregorian_date_to_jd(y + 1, 1, 1) <= jd; y++);
    for (m = 1; gregorian_date_to_jd(y, m + 1, 1) <= jd; m++);
    for (d = 1; gregorian_date_to_jd(y, m, d + 1) <= jd; d++);
    *yp = y; *mp = m; *dp = d;
}


int main(int argc, char* argv[]) {
    if (argc != 3) {
        fputs("usage: ch-1 birth_date today", stderr);
        return EXIT_FAILURE;
    }

    int by, bm, bd;
    if (sscanf(argv[1], "%d/%d/%d", &by, &bm, &bd) != 3) {
        fputs("invalid birth date", stderr);
        return EXIT_FAILURE;
    }

    int ty, tm, td;
    if (sscanf(argv[2], "%d/%d/%d", &ty, &tm, &td) != 3) {
        fputs("invalid birth date", stderr);
        return EXIT_FAILURE;
    }

    long bjd = gregorian_date_to_jd(by, bm, bd);
    long tjd = gregorian_date_to_jd(ty, tm, td);
    long days = tjd - bjd;
    long mirror1_jd = bjd - days;
    long mirror2_jd = tjd + days;

    int m1y, m1m, m1d;
    jd_to_gregorian_date(mirror1_jd, &m1y, &m1m, &m1d);

    int m2y, m2m, m2d;
    jd_to_gregorian_date(mirror2_jd, &m2y, &m2m, &m2d);

    printf("%04d/%02d/%02d, %04d/%02d/%02d\n", m1y, m1m, m1d, m2y, m2m, m2d);
}
