// Perl Weekly Challenge 230 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-230/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s prefix words...", argv[0]);

    int count = 0;
    const char* prefix = argv[1];
    for (int i = 2; i < argc; i++) {
        const char* word = argv[i];
        if (strncmp(prefix, word, strlen(prefix)) == 0)
            count++;
    }
    printf("%d\n", count);
}
