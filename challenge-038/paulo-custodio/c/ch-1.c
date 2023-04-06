/*
Challenge 038

TASK #1
Date Finder
Create a script to accept a 7 digits number, where the first number can only
be 1 or 2. The second and third digits can be anything 0-9. The fourth and
fifth digits corresponds to the month i.e. 01,02,03…,11,12. And the last
2 digits respresents the days in the month i.e. 01,02,03….29,30,31. Your
script should validate if the given number is valid as per the rule and then
convert into human readable format date.

RULES
If 1st digit is 1, then prepend 20 otherwise 19 to the 2nd and 3rd digits to
make it 4-digits year.

The 4th and 5th digits together should be a valid month.

The 6th and 7th digits together should be a valid day for the above month.

For example, the given number is 2230120, it should print 1923-01-20.
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool is_leap_year(int y) {
    return y % 400 == 0 ? true : y % 100 == 0 ? false : y % 4 == 0 ? true : false;
}

int days_of_month(int y, int m) {
    switch (m) {
    case 1: case 3: case 5: case 7: case 8: case 10: case 12: return 31;
    case 4: case 6: case 9: case 11: return 30;
    case 2: return is_leap_year(y) ? 29 : 28;
    default: assert(0); return -1;
    }
}

bool decode_date(int code, int* y, int* m, int* d) {
    *d = code % 100; code /= 100;
    if (*d < 1 || *d > 31) return false;

    *m = code % 100; code /= 100;
    if (*m < 1 || *m > 12) return false;

    int year_lsb = code % 100; code /= 100;
    int year_msb = code;
    if (year_msb != 1 && year_msb != 2) return false;

    *y = (year_msb == 1 ? 2000 : 1900) + year_lsb;

    if (*d > days_of_month(*y, *m)) return false;

    return true;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-1 date", stderr);
        return EXIT_FAILURE;
    }

    int date_code = atoi(argv[1]);
    int y, m, d;
    if (!decode_date(date_code, &y, &m, &d)) {
        fputs("invalid date", stderr);
        return EXIT_FAILURE;
    }

    printf("%04d-%02d-%02d\n", y, m, d);
}
