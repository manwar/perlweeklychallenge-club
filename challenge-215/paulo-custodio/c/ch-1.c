// Perl Weekly Challenge 215 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-215/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compare(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

bool is_sorted(const char* word) {
    char* sorted = xstrdup(word);
    qsort(sorted, strlen(sorted), sizeof(char),compare);
    bool ok = (strcmp(word, sorted) == 0);
    xfree(sorted);
    return ok;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    int count = 0;
    for (int i = 1; i < argc; i++) {
        const char* word = argv[i];
        if (!is_sorted(word))
            count++;
    }
    printf("%d\n", count);
}
