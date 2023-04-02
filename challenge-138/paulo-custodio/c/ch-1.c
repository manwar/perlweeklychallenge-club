/*
Challenge 138

TASK #1 > Workdays
Submitted by: Mohammad S Anwar
You are given a year, $year in 4-digits form.

Write a script to calculate the total number of workdays in the given year.

For the task, we consider, Monday - Friday as workdays.

Example 1
Input: $year = 2021
Output: 261
Example 2
Input: $year = 2020
Output: 262
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

int num_workdays(int y) {
    int wd = 0;
    for (int m = 1; m <= 12; m++) {
        int dom = days_of_month(y, m);
        for (int d = 1; d <= dom; d++) {
            int dow = day_of_week(y, m, d);
            if (dow != Sunday && dow != Saturday)
                wd++;
        }
    }
    return wd;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-1 year", stderr);
        return EXIT_FAILURE;
    }

    int y = atoi(argv[1]);
    printf("%d\n", num_workdays(y));
}
