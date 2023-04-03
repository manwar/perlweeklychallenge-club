/*
Challenge 048

TASK #2
Palindrome Dates
Write a script to print all Palindrome Dates between 2000 and 2999. The format
of date is mmddyyyy. For example, the first one was on October 2, 2001 as it is
represented as 10022001.
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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

bool is_palindrome(const char* str) {
    int i = 0, j = strlen(str)-1;
    while (i < strlen(str) && j >= 0) {
        if (str[i] != str[j])
            return false;
        i++; j--;
    }
    return true;
}

void print_palindrome_dates(int start_year, int end_year) {
    char date[BUFSIZ];

    for (int y = start_year; y <= end_year; y++) {
        for (int m = 1; m <= 12; m++) {
            int eom = days_of_month(y, m);
            for (int d = 1; d <= eom; d++) {
                sprintf(date, "%02d%02d%04d", m, d, y);
                if (is_palindrome(date))
                    printf("%s\n", date);
            }
        }
    }
}

int main() {
    print_palindrome_dates(2000, 2999);
}
