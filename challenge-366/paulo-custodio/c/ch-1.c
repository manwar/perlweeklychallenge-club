// Perl Weekly Challenge 366 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_prefix(const char* word, const char* prefix) {
    return strlen(prefix) <= strlen(word) && strncmp(prefix, word, strlen(prefix)) == 0;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage %s word prefixes...", argv[0]);

    int count = 0;
    const char* word = argv[1];
    for (int i = 2; i < argc; i++) {
        const char* prefix = argv[i];
        if (is_prefix(word, prefix))
            count++;
    }
    printf("%d\n", count);
}
