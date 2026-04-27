// Perl Weekly Challenge 370 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-370/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compare(const void* a, const void* b) {
    return *(const char*)a - *(const char*)b;
}

bool is_anagram(const char* a, const char* b) {
    if (strlen(a) != strlen(b))
        return false;
    char* a_sorted = xstrdup(a);
    qsort(a_sorted, strlen(a_sorted), sizeof(char), compare);
    char* b_sorted = xstrdup(b);
    qsort(b_sorted, strlen(b_sorted), sizeof(char), compare);
    
    bool ok = strcmp(a_sorted, b_sorted) == 0;
    
    xfree(a_sorted);
    xfree(b_sorted);
    
    return ok;
}

bool is_scramble(const char* a, const char* b) {
    if (strcmp(a, b) == 0)
        return true;
    if (strlen(a) != strlen(b))
        return false;
    if (!is_anagram(a, b))
        return false;
    
    int len = strlen(a);
    for (int split = 1; split < len; split++) {
        // no swap
        char* a1 = xstrndup(a, split);
        char* b1 = xstrndup(b, split);
        char* a2 = xstrdup(a + split);
        char* b2 = xstrdup(b + split);

        bool ok = is_scramble(a1, b1) && is_scramble(a2, b2);

        xfree(a1); xfree(b1); xfree(a2); xfree(b2);

        if (ok)
            return true;

        // swap
        a1 = xstrndup(a, split);
        b1 = xstrdup(b + len - split);
        a2 = xstrdup(a + split);
        b2 = xstrndup(b, len - split);

        ok = is_scramble(a1, b1) && is_scramble(a2, b2);

        xfree(a1); xfree(b1); xfree(a2); xfree(b2);

        if (ok)
            return true;
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s string1 string2", argv[0]);
    bool ok = is_scramble(argv[1], argv[2]);
    printf("%s\n", bool_to_string(ok));
}
