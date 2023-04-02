/*
Challenge 187

Task 1: Days Together
Submitted by: Mohammad S Anwar

Two friends, Foo and Bar gone on holidays seperately to the same city. You are
given their schedule i.e. start date and end date.

To keep the task simple, the date is in the form DD-MM and all dates belong to
the same calendar year i.e. between 01-01 and 31-12. Also the year is non-leap
year and both dates are inclusive.

Write a script to find out for the given schedule, how many days they spent
together in the city, if at all.
Example 1

Input: Foo => SD: '12-01' ED: '20-01'
       Bar => SD: '15-01' ED: '18-01'

Output: 4 days

Example 2

Input: Foo => SD: '02-03' ED: '12-03'
       Bar => SD: '13-03' ED: '14-03'

Output: 0 day

Example 3

Input: Foo => SD: '02-03' ED: '12-03'
       Bar => SD: '11-03' ED: '15-03'

Output: 2 days

Example 4

Input: Foo => SD: '30-03' ED: '05-04'
       Bar => SD: '28-03' ED: '02-04'

Output: 4 days
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define YEAR 2023   // any non-leap year

#define MIN(a, b)   ((a)<(b)?(a):(b))
#define MAX(a, b)   ((a)>(b)?(a):(b))

// https://pdc.ro.nu/jd-code.html
long gregorian_date_to_jd(int y, int m, int d) {
    y += 8000;
    if (m < 3) { y--; m += 12; }
    return (y * 365) + (y / 4) - (y / 100) + (y / 400) - 1200820
        + (m * 153 + 3) / 5 - 92 + d - 1;
}

int days_together(long as, long ae, long bs, long be) {
    if (bs > ae || as > be) return 0;
    long os = MAX(as, bs);
    long oe = MIN(ae, be);
    long days = oe - os + 1;
    return (int)days;
}

int main(int argc, char* argv[]) {
    if (argc != 5) {
        fputs("usage: ch-2 dd-mm dd-mm dd-mm dd-mm", stderr);
        return EXIT_FAILURE;
    }

    int d, m;
    if (sscanf(argv[1], "%d-%d", &d, &m) != 2) {
        fputs("invalid date", stderr);
        return EXIT_FAILURE;
    }
    long as = gregorian_date_to_jd(YEAR, m, d);

    if (sscanf(argv[2], "%d-%d", &d, &m) != 2) {
        fputs("invalid date", stderr);
        return EXIT_FAILURE;
    }
    long ae = gregorian_date_to_jd(YEAR, m, d);

    if (sscanf(argv[3], "%d-%d", &d, &m) != 2) {
        fputs("invalid date", stderr);
        return EXIT_FAILURE;
    }
    long bs = gregorian_date_to_jd(YEAR, m, d);

    if (sscanf(argv[4], "%d-%d", &d, &m) != 2) {
        fputs("invalid date", stderr);
        return EXIT_FAILURE;
    }
    long be = gregorian_date_to_jd(YEAR, m, d);

    int days = days_together(as, ae, bs, be);

    printf("%d\n", days);
}
