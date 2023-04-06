/*
Challenge 183

Task 2: Date Difference
Submitted by: Mohammad S Anwar

You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.

Write a script to find the difference between the given dates in terms on years
and days only.
Example 1

Input: $date1 = '2019-02-10'
       $date2 = '2022-11-01'
Output: 3 years 264 days

Example 2

Input: $date1 = '2020-09-15'
       $date2 = '2022-03-29'
Output: 1 year 195 days

Example 3

Input: $date1 = '2019-12-31'
       $date2 = '2020-01-01'
Output: 1 day

Example 4

Input: $date1 = '2019-12-01'
       $date2 = '2019-12-31'
Output: 30 days

Example 5

Input: $date1 = '2019-12-31'
       $date2 = '2020-12-31'
Output: 1 year

Example 6

Input: $date1 = '2019-12-31'
       $date2 = '2021-12-31'
Output: 2 years

Example 7

Input: $date1 = '2020-09-15'
       $date2 = '2021-09-16'
Output: 1 year 1 day

Example 8

Input: $date1 = '2019-09-15'
       $date2 = '2021-09-16'
Output: 2 years 1 day
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

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
        fputs("usage: ch-2 yyyy-mm-dd yyyy-mm-dd", stderr);
        return EXIT_FAILURE;
    }

    int y1, m1, d1;
    if (sscanf(argv[1], "%d-%d-%d", &y1, &m1, &d1) != 3) {
        fputs("invalid date", stderr);
        return EXIT_FAILURE;
    }
    long jd1 = gregorian_date_to_jd(y1, m1, d1);

    int y2, m2, d2;
    if (sscanf(argv[2], "%d-%d-%d", &y2, &m2, &d2) != 3) {
        fputs("invalid date", stderr);
        return EXIT_FAILURE;
    }
    long jd2 = gregorian_date_to_jd(y2, m2, d2);

    int years = 0;
    while (gregorian_date_to_jd(y1 + years + 1, m1, d1) <= jd2)
        years++;
    jd1 = gregorian_date_to_jd(y1 + years, m1, d1);

    if (years != 0)
        printf("%d year%s ", years, years == 1 ? "" : "s");

    int days = jd2 - jd1;
    if (days != 0)
        printf("%d day%s ", days, days == 1 ? "" : "s");
    printf("\n");
}
