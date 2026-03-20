// Perl Weekly Challenge 229 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-229/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compare_ascending(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

int compare_descending(const void* a, const void* b) {
    return *(char*)b - *(char*)a;
}

bool is_sorted(const char* word) {
    char* ascending = xstrdup(word);
    qsort(ascending, strlen(word), sizeof(char), compare_ascending);

    char* descending = xstrdup(word);
    qsort(descending, strlen(word), sizeof(char), compare_descending);

    bool ok = strcmp(word, ascending)==0 || strcmp(word, descending)==0;

    xfree(ascending);
    xfree(descending);

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
