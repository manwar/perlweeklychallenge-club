// Perl Weekly Challenge 280 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-280/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char count_stars(const char* str) {
    int count = 0;
    bool in_bars = false;
    for (const char* p = str; *p; p++) {
        if (*p == '|')
            in_bars = !in_bars;
        else if (*p == '*' && !in_bars)
            count++;
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    int count = count_stars(argv[1]);
    printf("%d\n", count);
}
