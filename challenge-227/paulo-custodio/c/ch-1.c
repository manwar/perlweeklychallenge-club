// Perl Weekly Challenge 227 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-227/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define FRIDAY 5

int num_friday_13ths(int year) {
    int count_fri13th = 0;
    for (int mon = 1; mon <= 12; mon++) {
        struct tm t1 = {0};
        t1.tm_year = year - 1900;
        t1.tm_mon = mon - 1;
        t1.tm_mday = 13;

        time_t date = mktime(&t1);
        if (date == (time_t)-1)
            die("Invalid date");

        if (t1.tm_wday == FRIDAY)
            count_fri13th++;
    }
    return count_fri13th;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s year", argv[0]);

    int count_fri13th = num_friday_13ths(atoi(argv[1]));
    printf("%d\n", count_fri13th);
}
