// Perl Weekly Challenge 280 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-280/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char first_double_letter(const char* str) {
    int count[UCHAR_MAX] = {0};
    for (const char* p = str; *p; p++) {
        count[*p]++;
        if (count[*p] == 2)
            return *p;
    }
    return ' ';
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    char first = first_double_letter(argv[1]);
    printf("%c\n", first);
}
