// Perl Weekly Challenge 239 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-239/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_allowed(const char* allowed, const char* str) {
    for (const char* p = str; *p; p++) {
        if (strchr(allowed, *p) == NULL)
            return false;
    }
    return true;
}

int count_allowed(const char* allowed, StrArray* strs) {
    int count = 0;
    for (int i = 0; i < strs->size; i++) {
        if (is_allowed(allowed, strs->data[i]))
            count++;
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s allowed strings...", argv[0]);

    const char* allowed = argv[1];
    StrArray* strs = strarray_new();
    for (int i = 2; i < argc; i++)
        strarray_push_back(strs, argv[i]);

    int count = count_allowed(allowed, strs);
    printf("%d\n", count);
    strarray_free(strs);
}
