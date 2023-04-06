/*
Challenge 030

Task #1
Write a script to list dates for Sunday Christmas between 2019 and 2100. For
example, 25 Dec 2022 is Sunday.
*/

#include <assert.h>
#include <stdio.h>
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

void print_sunday_christmas(int start_year, int end_year) {
    const char* sep = "";
    for (int y = start_year; y <= end_year; y++) {
        if (day_of_week(y, 12, 25) == Sunday) {
            printf("%s%04d", sep, y);
            sep = ", ";
        }
    }
    printf("\n");
}

int main() {
    print_sunday_christmas(2019, 2100);
}
