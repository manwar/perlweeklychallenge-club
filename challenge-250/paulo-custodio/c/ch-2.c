// Perl Weekly Challenge 250 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-250/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_digits_only(const char* str) {
    if (strlen(str) == 0)
        return false;

    for (const char* p = str; *p; p++) {
        if (!isdigit(*p))
            return false;
    }

    return true;
}

int string_value(const char* str) {
    if (is_digits_only(str))
        return atoi(str);
    else
        return strlen(str);
}

int max_string_value(StrArray* strs) {
    int max = 0;
    for (int i = 0; i < strs->size; i++)
        max = MAX(max, string_value(strs->data[i]));
    return max;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s strs...", argv[0]);

    StrArray* strs = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(strs, argv[i]);

    int max = max_string_value(strs);
    printf("%d\n", max);

    strarray_free(strs);
}
