/*
Challenge 178

Task 2: Business Date
Submitted by: Mohammad S Anwar

You are given $timestamp (date with time) and $duration in hours.

Write a script to find the time that occurs $duration business hours after
$timestamp. For the sake of this task, let us assume the working hours is 9am
to 6pm, Monday to Friday. Please ignore timezone too.

For example,

Suppose the given timestamp is 2022-08-01 10:30 and the duration is 4 hours.
Then the next business date would be 2022-08-01 14:30.

Similar if the given timestamp is 2022-08-01 17:00 and the duration is 3.5 hours.
Then the next business date would be 2022-08-02 11:30.
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define DAY_START   9
#define DAY_END     18

enum { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday };

int day_of_week(int y, int m, int d) {
    return (d += m < 3 ? y-- : y - 2, 23*m/9 + d + 4 + y/4- y/100 + y/400)%7;
}

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

void next_business_date(int* y, int* m, int* d, int* hh, int* mm, int minutes) {
    while (true) {
        int now = *hh * 60 + *mm;
        int end_day = DAY_END * 60;
        if (now + minutes < end_day) {
            *mm += minutes % 60;
            *hh += minutes / 60;
            return;
        }
        minutes -= end_day - now;
        long jd = gregorian_date_to_jd(*y, *m, *d);
        int dow;
        do {
            jd++;
            jd_to_gregorian_date(jd, y, m, d);
            dow = day_of_week(*y, *m, *d);
        } while (dow == Saturday || dow == Sunday);
        *hh = DAY_START;
        *mm = 0;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        fputs("usage: ch-2 yyyy-mm-dd HH:MM hours", stderr);
        return EXIT_FAILURE;
    }

    int y, m, d;
    if (sscanf(argv[1], "%d-%d-%d", &y, &m, &d) != 3) {
        fputs("invalid date", stderr);
        return EXIT_FAILURE;
    }

    int hh, mm;
    if (sscanf(argv[2], "%d:%d", &hh, &mm) != 2) {
        fputs("invalid hour", stderr);
        return EXIT_FAILURE;
    }

    float hours;
    if (sscanf(argv[3], "%f", &hours) != 1) {
        fputs("invalid hours", stderr);
        return EXIT_FAILURE;
    }

    next_business_date(&y, &m, &d, &hh, &mm, (int)(hours*60));

    printf("%04d-%02d-%02d %02d:%02d\n", y, m, d, hh, mm);
}
