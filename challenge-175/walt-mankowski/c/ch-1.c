#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

const bool is_leap_year(const int year) {
    if (year % 4)
        return false;
    else if (year % 100)
        return true;
    else if (year % 400)
        return false;
    else
        return true;
}

int main(int argc, char *argv[]) {
    const int days_in_month[2][12] = {
        { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
        { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
    };

    const int year = atoi(argv[1]);
    const int leap = is_leap_year(year);
    for (int month = 0; month < 12; month++) {
        struct tm ts;
        memset(&ts, 0, sizeof(ts));
        ts.tm_mon = month;
        ts.tm_year = year - 1900;
        ts.tm_mday = days_in_month[leap][month];
        ts.tm_isdst = -1;
        mktime(&ts);
        printf("%d-%02d-%2d\n", ts.tm_year + 1900, month+1, ts.tm_mday - ts.tm_wday);
    }
}
