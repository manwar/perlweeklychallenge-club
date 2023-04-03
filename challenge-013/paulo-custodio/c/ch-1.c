/*
Challenge 013

Challenge #1
Write a script to print the date of last Friday of every month of a given year.
For example, if the given year is 2019 then it should print the following:

2019/01/25
2019/02/22
2019/03/29
2019/04/26
2019/05/31
2019/06/28
2019/07/26
2019/08/30
2019/09/27
2019/10/25
2019/11/29
2019/12/27
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

void last_friday_month(int y, int m, int* d) {
    *d = days_of_month(y, m);
    while (day_of_week(y, m, *d) != Friday)
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
        last_friday_month(y, m, &d);
        printf("%04d/%02d/%02d\n", y, m, d);
    }
}
