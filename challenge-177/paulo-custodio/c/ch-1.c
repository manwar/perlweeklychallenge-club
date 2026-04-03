// Perl Weekly Challenge 177 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-177/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

static int table[10][10] = {
    { 0,  3,   1,   7,   5,   9,   8,   6,   4,   2 },
    { 7,  0,   9,   2,   1,   5,   4,   8,   6,   3 },
    { 4,  2,   0,   6,   8,   7,   1,   3,   5,   9 },
    { 1,  7,   5,   0,   9,   8,   3,   4,   2,   6 },
    { 6,  1,   2,   3,   0,   4,   5,   9,   7,   8 },
    { 3,  6,   7,   4,   2,   0,   9,   5,   8,   1 },
    { 5,  8,   6,   9,   7,   2,   0,   1,   3,   4 },
    { 8,  9,   4,   5,   3,   6,   2,   0,   1,   7 },
    { 9,  4,   3,   8,   6,   1,   7,   2,   0,   5 },
    { 2,  5,   8,   1,   4,   3,   6,   7,   9,   0 },
};

bool validate(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    int digit = 0;
    for (int i = 0; buffer[i] != '\0'; i++) {
        char in_digit = buffer[i] - '0';
        digit = table[digit][in_digit];
    }
    return digit==0 ? true : false;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    bool ok = validate(atoi(argv[1]));
    printf("%d\n", ok);
}
