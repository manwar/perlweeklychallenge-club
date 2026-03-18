// Perl Weekly Challenge 358 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-358/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define LETTERS ('z'-'a'+1)

char* encrypt(const char* str, int n) {
    char* coded = xstrdup(str);

    for (char* p = coded; *p != '\0'; p++) {
        if (*p >= 'a' && *p <= 'z') {
            *p = (((*p - 'a') + n + LETTERS) % LETTERS) + 'a';
        }
    }
    return coded;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s str n\n", argv[0]);

    const char* str = argv[1];
    int n = atoi(argv[2]);

    char* coded = encrypt(str, n);

    printf("%s\n", coded);
    free(coded);
}
