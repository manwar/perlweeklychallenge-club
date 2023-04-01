/*
Challenge 175

Task 1: Last Sunday
Submitted by: Mohammad S Anwar

Write a script to list Last Sunday of every month in the given year.

For example, for year 2022, we should get the following:

2022-01-30
2022-02-27
2022-03-27
2022-04-24
2022-05-29
2022-06-26
2022-07-31
2022-08-28
2022-09-25
2022-10-30
2022-11-27
2022-12-25
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

enum { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday };

int day_of_week(int y, int m, int d) {
    return (d += m < 3 ? y-- : y - 2, 23*m/9 + d + 4 + y/4- y/100 + y/400)%7;
}

bool is_leap_year(int y) {
    return y%400==0 ? true : y%100==0 ? false : y%4==0 ? true : false;
}

int days_of_month(int y, int m) {
    switch (m) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12: return 31;
        case 4: case 6: case 9: case 11: return 30;
        case 2: return is_leap_year(y) ? 29 : 28;
        default: assert(0);
    }
}

void last_sunday_month(int y, int m, int* d) {
    *d = days_of_month(y, m);
    while (day_of_week(y, m, *d) != Sunday)
        (*d)--;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-1 year", stderr);
        return EXIT_FAILURE;
    }

    int y = atoi(argv[1]);
    for (int m = 1; m <= 12; m++) {
        int d;
        last_sunday_month(y, m, &d);
        printf("%04d-%02d-%02d\n", y, m, d);
    }
}
