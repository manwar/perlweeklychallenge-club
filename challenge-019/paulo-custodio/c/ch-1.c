/*
Challenge 019

Task #1
Write a script to display months from the year 1900 to 2019 where you find
5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

Solution: 4 weeks are 28 days, to have 5 week-ends we need additional 3 days
(29,30,31),
therefore 31st must be a Sunday
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

bool five_weekends(int y, int m) {
    return days_of_month(y, m) == 31 && day_of_week(y, m, 31) == Sunday;
}

int main() {
    for (int y = 1900; y <= 2019; y++) {
            for (int m = 1; m <= 12; m++) {
                if (five_weekends(y, m))
                    printf("%04d-%02d\n", y, m);
            }
    }
}
