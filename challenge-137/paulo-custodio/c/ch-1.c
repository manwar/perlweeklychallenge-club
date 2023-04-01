/*
Challenge 137

TASK #1 > Long Year
Submitted by: Mohammad S Anwar
Write a script to find all the years between 1900 and 2100 which is a Long
Year.

A year is Long if it has 53 weeks.


[UPDATED][2021-11-01 16:20:00]: For more information about Long Year, please
refer to wikipedia.

Expected Output
1903, 1908, 1914, 1920, 1925,
1931, 1936, 1942, 1948, 1953,
1959, 1964, 1970, 1976, 1981,
1987, 1992, 1998, 2004, 2009,
2015, 2020, 2026, 2032, 2037,
2043, 2048, 2054, 2060, 2065,
2071, 2076, 2082, 2088, 2093,
2099

https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
years in which 1 January or 31 December are Thursdays
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

enum { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday };

int day_of_week(int y, int m, int d) {
    return (d += m < 3 ? y-- : y - 2, 23*m/9 + d + 4 + y/4- y/100 + y/400)%7;
}

bool is_long_year(int y) {
    if (day_of_week(y,1,1) == Thursday || day_of_week(y,12,31) == Thursday)
        return true;
    else
        return false;
}

int main() {
    int col = 0;
    const char* sep = "";
    for (int y = 1900; y <= 2100; y++) {
        if (is_long_year(y)) {
            printf("%s%d", sep, y);
            sep = ", ";
            col++;
            if (col == 5) {
                col = 0;
                sep = ",\n";
            }
        }
    }
    printf("\n");
}
