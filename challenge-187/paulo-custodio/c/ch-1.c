// Perl Weekly Challenge 187 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-187/

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
