// Perl Weekly Challenge 366 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_minutes(const char* t) {
    if (strlen(t) != 5 || t[2] != ':')
        return 0;

    char h1 = t[0];
    char h2 = t[1];
    char m1 = t[3];
    char m2 = t[4];

    int hours =
        (h1 == '?' && h2 == '?') ? 24 :
        (h1 == '?') ? (
            (h2 <= '9' ? 1 : 0) +      // h1=0
            (h2 <= '9' ? 1 : 0) +      // h1=1
            (h2 <= '3' ? 1 : 0)        // h1=2
        ) :
        (h2 == '?') ? (
            (h1 == '0' || h1 == '1') ? 10 : 4
        ) :
        (atoi(t) <= 23 ? 1 : 0);

    int minutes =
        (m1 == '?' ? 6 : 1) *
        (m2 == '?' ? 10 : 1);

    return hours * minutes;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s hh:mm", argv[0]);

    int minutes = count_minutes(argv[1]);
    printf("%d\n", minutes);
}
