// Perl Weekly Challenge 237 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-237/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define DAY (24*60*60)

int find_day(int year, int month, int wdom, int dow) {
    if (dow == 7) dow = 0;      // make compatible with struct tm

    struct tm t1 = {0};
    t1.tm_year = year - 1900;
    t1.tm_mon = month - 1;
    t1.tm_mday = 1;

    int count_wdom = 0;
    time_t date = mktime(&t1);
    if (date == (time_t)-1)
        die("Invalid date");

    while (true) {
        struct tm* t2 = gmtime(&date);
        if (t2->tm_mon != t1.tm_mon)
            return 0;       // not found

        if (t2->tm_wday == dow) {
            count_wdom++;
            if (count_wdom == wdom)
                return t2->tm_mday;
        }

        date += DAY;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 5)
        die("usage: %s year month wdom dow", argv[0]);

    int day = find_day(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]));
    printf("%d\n", day);
}
