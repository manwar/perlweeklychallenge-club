// Perl Weekly Challenge 188 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-188/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int make_zero(int x, int y) {
    int ops = 0;
    while (x > 0 || y > 0) {
        if (x == y)
            x = y = 0;
        else if (x > y)
            x -= y;
        else
            y -= x;
        ops++;
    }
    return ops;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s x y", argv[0]);

    int x = atoi(argv[1]);
    int y = atoi(argv[2]);
    int ops = make_zero(x, y);
    printf("%d\n", ops);
}
