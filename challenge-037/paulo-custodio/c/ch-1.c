/*
Challenge 037

TASK #1
Write a script to calculate the total number of weekdays (Mon-Fri) in each
month of the year 2019.
Jan: 23 days
Feb: 20 days
Mar: 21 days
Apr: 22 days
May: 23 days
Jun: 20 days
Jul: 23 days
Aug: 22 days
Sep: 21 days
Oct: 23 days
Nov: 21 days
Dec: 22 days
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

const char* Months[] = {
    NULL,
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
};

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

int weekdays_of_month(int y, int m) {
    int dom = days_of_month(y, m);
    int workdays = 0;
    for (int d = 1; d <= dom; d++) {
        switch (day_of_week(y, m, d)) {
        case Saturday: case Sunday: break;
        default: workdays++; break;
        }
    }
    return workdays;
}

void print_weekdays_of_month(int y) {
    for (int m = 1; m <= 12; m++)
        printf("%s: %d days\n", Months[m], weekdays_of_month(y, m));
}

int main() {
    print_weekdays_of_month(2019);
}
